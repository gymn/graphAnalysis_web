package com.info.service.impl;

import com.info.dao.LinkDao;
import com.info.dao.NodeDao;
import com.info.model.Graph;
import com.info.model.Link;
import com.info.model.Metrics;
import com.info.model.Node;
import com.info.service.CommonGraphService;
import com.info.utils.Utils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.*;

@Service
public class TestGraphServiceImpl implements CommonGraphService{
    @Autowired
    NodeDao nodeDao;

    @Autowired
    LinkDao linkDao;
    @Override
    public Graph getGraph(String tableName) {
        String nodeTable = tableName+"_node";
        String linkTable = tableName+"_link";

        Graph graph = new Graph();

        List<Node> nodeList = nodeDao.getNodeList(nodeTable);
        graph.setNodes(nodeList.toArray(new Node[nodeList.size()]));

        List<Link> linkList = linkDao.getLinkList(linkTable);
        graph.setLinks(linkList.toArray(new Link[linkList.size()]));
        return graph;
    }

    private static class Point{
        Double x;
        Double y;
        Point(Double x,Double y){
            this.x = x;
            this.y = y;
        }
    }

    @Override
    public Metrics getMetricsTLP(Graph graph, Graph testGraph) {
        Link[] links = graph.getLinks();
        List<Link> allLinkList = linkDao.getLinkList("tl_link");
        Link[] allLinks = allLinkList.toArray(new Link[allLinkList.size()]);

        Link[] testLinks = testGraph.getLinks();

        int count = 0;
        for(int i=0;i<links.length;i++) {
            for (int j = 0; j < testLinks.length; j++) {
                if (testLinks[j].equals(links[i])){
                    count++;
                }
            }
        }
        double precision = count*1.0/links.length;

        ArrayList<Link> testLinkList = new ArrayList<>(Arrays.asList(testLinks));

        Object[] scores = Arrays.stream(allLinks).map(Link::getWeight).sorted((a, b)->a.compareTo(b)*-1).toArray();
        HashMap<Link,Boolean> linkMap = new HashMap<>(allLinks.length);

        int n = 0;
        int p = testLinks.length;
        for(int i=0;i<allLinks.length;i++){
            boolean in = testLinkList.contains(allLinks[i]);
            if(!in) {
                n++;
            }
            linkMap.put(allLinks[i], in);
        }


        ArrayList<Point> points = new ArrayList<>();

        for(int i=0;i<scores.length;i++){
            Double score = (Double)scores[i];
            Double fp = Arrays.stream(allLinks).filter(link->link.getWeight()>=score&&!linkMap.get(link)).toArray().length*1.0;
            Double x = n==0?1:fp/n;
            Double pt = Arrays.stream(allLinks).filter(link->link.getWeight()>=score&&linkMap.get(link)).toArray().length*1.0;
            Double y = p==0?1:pt/p;
            points.add(new Point(x,y));
        }
        points.add(new Point(1.0,1.0));

        Double areaUnderCurve = 0.0;
        Point point1 = new Point(0.0,0.0);
        Point point2 = points.get(0);
        areaUnderCurve += (point2.y+point1.y)*(point2.x-point1.x)/2;
        for(int i=1;i<points.size();i++){
            point1 = point2;
            point2 = points.get(i);
            areaUnderCurve += (point2.y+point1.y)*(point2.x-point1.x)/2;
        }

        Metrics metrics = new Metrics();
        metrics.setPrecision(Utils.round2(precision));
        metrics.setAuc(Utils.round2(Math.sqrt(areaUnderCurve)));
        return metrics;
    }

    @Override
    public Metrics getMetricsLCD(Graph graph, Graph testGraph) {
        Node[] nodes = graph.getNodes();
        Node[] testNodes = testGraph.getNodes();
        int countRealLCNodes=0, countCalLcNodes=0, countCorrectNodes=0;
        for(int i=0;i<nodes.length;i++){
            if(nodes[i].getCategory()==1){
                countCalLcNodes++;
                for(int j=0;j<testNodes.length;j++){
                    if(nodes[i].getName().equals(testNodes[j].getName())){
                        if(testNodes[j].getCategory()==1) {
                            countCorrectNodes++;
                        }else{
                            break;
                        }
                    }
                }
            }
        }

        for(Node node: testNodes){
            if(node.getCategory()==1){
                countRealLCNodes++;
            }
        }

        double precision = countCorrectNodes*1.0/countCalLcNodes;
        double recall = countCorrectNodes*1.0/countRealLCNodes;
        double f = 2*precision*recall/(precision+recall);

        Metrics metrics = new Metrics();
        metrics.setPrecision(Utils.round2(precision));
        metrics.setRecall(Utils.round2(recall));
        metrics.setF(Utils.round2(f));
        return metrics;
    }
}
