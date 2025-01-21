

import javax.swing.BorderFactory;
import javax.swing.Box;
import javax.swing.BoxLayout;
import javax.swing.JFrame;
import javax.swing.JPanel;
import javax.swing.SwingConstants;
import javax.swing.SwingUtilities;

import java.awt.*;
import java.awt.event.MouseEvent;
import java.awt.geom.Point2D;
import java.util.*;

import prefuse.Constants;
import prefuse.Display;
import prefuse.Visualization;
import prefuse.action.Action;
import prefuse.action.ActionList;
import prefuse.action.GroupAction;
import prefuse.action.RepaintAction;
import prefuse.action.animate.ColorAnimator;
import prefuse.action.animate.LocationAnimator;
import prefuse.action.animate.PolarLocationAnimator;
import prefuse.action.animate.QualityControlAnimator;
import prefuse.action.animate.VisibilityAnimator;
import prefuse.action.assignment.ColorAction;
import prefuse.action.assignment.DataSizeAction;
import prefuse.action.assignment.DataColorAction;
import prefuse.action.assignment.FontAction;
import prefuse.action.filter.FisheyeTreeFilter;
import prefuse.action.filter.GraphDistanceFilter;
import prefuse.action.layout.CollapsedSubtreeLayout;
import prefuse.action.layout.graph.ForceDirectedLayout;
import prefuse.action.layout.graph.NodeLinkTreeLayout;
import prefuse.action.layout.graph.RadialTreeLayout;
import prefuse.activity.Activity;
import prefuse.activity.SlowInSlowOutPacer;
import prefuse.controls.*;
import prefuse.data.*;
import prefuse.data.event.TupleSetListener;
import prefuse.data.query.SearchQueryBinding;
import prefuse.data.search.PrefixSearchTupleSet;
import prefuse.data.search.SearchTupleSet;
import prefuse.data.tuple.DefaultTupleSet;
import prefuse.data.tuple.TupleSet;
import prefuse.render.*;
import prefuse.util.ColorLib;
import prefuse.util.FontLib;
import prefuse.util.GraphLib;
import prefuse.util.PrefuseLib;
import prefuse.util.ui.JFastLabel;
import prefuse.util.ui.JSearchPanel;
import prefuse.util.ui.UILib;
import prefuse.visual.DecoratorItem;
import prefuse.visual.NodeItem;
import prefuse.visual.VisualGraph;
import prefuse.visual.VisualItem;
import prefuse.visual.expression.InGroupPredicate;
import prefuse.visual.sort.ItemSorter;
import prefuse.visual.sort.TreeDepthItemSorter;

import idot.*;
import idot.util.*;

/**
 * A minimalistic graph demo showing how to add data manually to a graph instead of reading it from a file.
 * More or less a cut down of the AggregateDemo of the prefuse download
 * 
 * @author <a href="http://jheer.org">jeffrey heer</a>
 * @author <a href="http://goosebumpsall.net">martin dudek</a>
 *
 */


public class JobGraph extends Display {
	
	private static final String LABEL = "label";
	private static final String SIZE = "size";
	private static final String GENDER = "gender";
	private static final String COLOR = "color";
	private static final String TOOLTIP = "toolTip";
	
	private static final String GRAPH = "graph";
	private static final String NODES = "graph.nodes";
	private static final String EDGES = "graph.edges";
	private static final String LINEAR = "linear";
	
	private JFastLabel jFastLabel = new JFastLabel();
    
	public JobGraph(Map<String,String> paramMap) {
		
		
        
        super(new Visualization());
        
        Map<String,String> paletteMap = initDataGroups(paramMap);
        
        zoom(getDisplayCenter(),1.3);
        //animateZoom( getDisplayCenter(), 1.5/ getScale(), 1000 );
        
        LabelRenderer nodeRenderer = new LabelRenderer(LABEL);
        nodeRenderer.setRoundedCorner(8,8);
        
        TransitionRenderer edgeRenderer = new TransitionRenderer();
        //edgeRenderer.setEdgeType(Constants.EDGE_TYPE_LINE);
        edgeRenderer.setArrowType(Constants.EDGE_ARROW_FORWARD);
        
        DefaultRendererFactory drf = new DefaultRendererFactory(nodeRenderer,edgeRenderer);
        drf.add(new InGroupPredicate(EDGES), edgeRenderer);
        m_vis.setRendererFactory(drf);
        
        
        ColorAction nText = new ColorAction(NODES, VisualItem.TEXTCOLOR);
        nText.setDefaultColor(ColorLib.color(Color.decode("#708090")));
        
        ColorAction nStroke = new ColorAction(NODES, VisualItem.STROKECOLOR);
        nStroke.setDefaultColor(ColorLib.gray(100));
        
        //ColorAction nFill = new ColorAction(NODES, VisualItem.FILLCOLOR);
        //nFill.setDefaultColor(ColorLib.gray(255));
        
        ArrayList<Integer> alPalette = new ArrayList(); 
        if( paletteMap.containsKey("Ended_OK") ) alPalette.add(ColorLib.color(Color.decode("#31CE31")));
        if( paletteMap.containsKey("Ended_Not_OK") ) alPalette.add(ColorLib.color(Color.decode("#FF0000")));
        if( paletteMap.containsKey("Executing") ) alPalette.add(ColorLib.color(Color.decode("#CECE00")));
        if( paletteMap.containsKey("Wait_Time") ) alPalette.add(ColorLib.color(Color.decode("#FFCC66")));        
        if( paletteMap.containsKey("Wait_Condition") ) alPalette.add(ColorLib.color(Color.decode("#999999")));
        if( paletteMap.containsKey("Wait_Resource") ) alPalette.add(ColorLib.color(Color.decode("#3131CE")));
        if( paletteMap.containsKey("Wait_User") ) alPalette.add(ColorLib.color(Color.decode("#FF31CE")));
        if( paletteMap.containsKey("Unknown") ) alPalette.add(ColorLib.color(Color.decode("#FFFFE6")));
        if( paletteMap.containsKey("Not_in_AJF") ) alPalette.add(ColorLib.color(Color.decode("#CEFFFF")));
        if( paletteMap.containsKey("Etc") ) alPalette.add(ColorLib.color(Color.decode("#CEFFFF")));
        if( paletteMap.containsKey("Held") ) alPalette.add(ColorLib.color(Color.decode("#FF9966")));
        if( paletteMap.containsKey("Deleted") ) alPalette.add(ColorLib.color(Color.decode("#003333")));
        if( paletteMap.containsKey("Click_Job") ) alPalette.add(ColorLib.color(Color.decode("#FFE4C4")));
        if( paletteMap.containsKey("Condition") ) alPalette.add(ColorLib.color(Color.decode("#FAFAD2")));
        
        int[] palette = new int[alPalette.size()];
        for(int i=0; i<palette.length; i++){
        	palette[i] = alPalette.get(i);
        }
        
        // map nominal data values to colors using our provided palette
        DataColorAction nFill = new DataColorAction(NODES, GENDER, Constants.NOMINAL, VisualItem.FILLCOLOR,palette);
        nFill.add("_hover", ColorLib.color(Color.decode("#FFFFFF")));
        nFill.add("ingroup('_search_')", ColorLib.color(Color.decode("#FFFFFF")));
        
        ColorAction eStroke = new ColorAction(EDGES, VisualItem.STROKECOLOR);
        eStroke.setDefaultColor(ColorLib.gray(100));
        
        ColorAction eFill = new ColorAction(EDGES, VisualItem.FILLCOLOR);
        eFill.setDefaultColor(ColorLib.rgb(190,190,255));
        
        // bundle the color actions
        ActionList draw = new ActionList();
        draw.add(nText);
        draw.add(nStroke);
        draw.add(nFill);
        draw.add(eStroke);
        draw.add(eFill);
        
        m_vis.putAction("draw", draw);
        
        ActionList reDraw = new ActionList();
        reDraw.add(draw);
        reDraw.add(new RepaintAction());
		m_vis.putAction("reDraw", reDraw);
        
		// now create the main animate routine
		ActionList animate = new ActionList(Activity.DEFAULT_STEP_TIME);
        //ActionList animate = new ActionList(1250);
        animate.setPacingFunction(new SlowInSlowOutPacer());
        animate.add(new ForceDirectedLayout(GRAPH,false));
        animate.add(new QualityControlAnimator());
        animate.add(new LocationAnimator(NODES));
        animate.add(new VisibilityAnimator(GRAPH));
        animate.add(new ColorAnimator(NODES));
        animate.add(new RepaintAction());
        m_vis.putAction("animate", animate);
        
        
        // set up the display
        //setSize(1000,700);
        
        setItemSorter(new TreeDepthItemSorter());
        setHighQuality(true);
        //addControlListener(new ZoomToFitControl());
        addControlListener(new ZoomControl());
        addControlListener(new WheelZoomControl());
        addControlListener(new PanControl());
        addControlListener(new DragControl());
        addControlListener(new HoverActionControl("reDraw"));
        addControlListener(new NeighborHighlightControl("reDraw"));
        
        ToolTipControl ttc = new ToolTipControl(TOOLTIP);
        Control hoverc = new ControlAdapter() {
        	public void itemEntered(VisualItem item, MouseEvent evt) {
        		if ( item.isInGroup("by_state") ) {
        			jFastLabel.setText(item.getString(TOOLTIP));
        			item.setFillColor(item.getStrokeColor());
        			item.setStrokeColor(ColorLib.rgb(0,0,0));
        			item.getVisualization().repaint();
        		}
        	}
        	public void itemExited(VisualItem item, MouseEvent evt) {
        		if ( item.isInGroup("by_state") ) {
        			jFastLabel.setText(null);
        			item.setFillColor(item.getEndFillColor());
        			item.setStrokeColor(item.getEndStrokeColor());
        			item.getVisualization().repaint();
        		}
        	}
        };
        addControlListener(ttc);
        addControlListener(hoverc);
        
        
        m_vis.runAfter("draw","animate");
        m_vis.run("draw");
        
        NodeLinkTreeLayout treeLayout = new NodeLinkTreeLayout(GRAPH);
        treeLayout.setOrientation(Constants.ORIENT_TOP_BOTTOM);
        m_vis.putAction("treeLayout", treeLayout);
        
        m_vis.run("treeLayout");
        
        SearchTupleSet search = new PrefixSearchTupleSet();
		m_vis.addFocusGroup(Visualization.SEARCH_ITEMS, search);
		search.addTupleSetListener(new TupleSetListener() {
			public void tupleSetChanged(TupleSet t, Tuple[] add, Tuple[] rem) {
				m_vis.cancel("draw");
				m_vis.run("reDraw");
			}
		});
    
    }
    
    private Map<String,String> initDataGroups(Map<String,String> paramMap) {
    	
    	Map<String,String> statusMap = new HashMap<String,String>();
    	statusMap.put("Ended_OK","Job Success");
    	statusMap.put("Ended_Not_OK","Job Fail");
    	statusMap.put("Executing","Running");
    	statusMap.put("Wait_Time","Wait Time");
    	statusMap.put("Wait_Condition","Wait Condition");
    	statusMap.put("Wait_Resource","Wait Resource");
    	statusMap.put("Wait_User","Wait Confirm");
    	statusMap.put("Unknown","Unknown");
    	statusMap.put("Not_in_AJF","Etc");
    	statusMap.put("Etc","Etc");
    	statusMap.put("Held","Hold");
    	statusMap.put("Deleted","Deleted");
    	statusMap.put("Click_Job","Click Job");
    	statusMap.put("Condition","Condition");    	
    	
    	Map<String,String> colorMap = new HashMap<String,String>();
    	colorMap.put("Ended_OK","A");
    	colorMap.put("Ended_Not_OK","B");
    	colorMap.put("Executing","C");
    	colorMap.put("Wait_Time","D");
    	colorMap.put("Wait_Condition","E");
    	colorMap.put("Wait_Resource","F");
    	colorMap.put("Wait_User","G");
    	colorMap.put("Unknown","H");
    	colorMap.put("Not_in_AJF","I");
    	colorMap.put("Etc","J");
    	colorMap.put("Held","K");
    	colorMap.put("Deleted","L");
    	colorMap.put("Click_Job","M");
    	colorMap.put("Condition","N");
    	
    	String order_id = paramMap.get("order_id");
		
		String[] preNodeOrderIds 		= paramMap.get("preNodeOrderIds").split(",");
		String[] preNodeRefOrderIds 	= paramMap.get("preNodeRefOrderIds").split(",");
		String[] preNodeJobNames 		= paramMap.get("preNodeJobNames").split(",");
		String[] preNodeState_results 	= paramMap.get("preNodeState_results").split(",");
		
		String[] nextNodeOrderIds 		= paramMap.get("nextNodeOrderIds").split(",");
		String[] nextNodeRefOrderIds 	= paramMap.get("nextNodeRefOrderIds").split(",");
		String[] nextNodeJobNames 		= paramMap.get("nextNodeJobNames").split(",");
		String[] nextNodeState_results 	= paramMap.get("nextNodeState_results").split(",");
		
    	Graph g = new Graph();
		
    	g.addColumn(LABEL, String.class);
		g.addColumn(GENDER, String.class);
		g.addColumn(TOOLTIP, String.class);
		
		Map<String,Node> nodeMap = new HashMap<String,Node>();
		Map<String,String> paletteMap = new HashMap<String,String>();
		
		for(int i=preNodeOrderIds.length-1;i>=0;i-- ){
			if(nodeMap.containsKey(preNodeOrderIds[i])) continue;			
			nodeMap.put(preNodeOrderIds[i], this.createNode(g,preNodeJobNames[i]+"\n ("+statusMap.get(preNodeState_results[i].replaceAll(" ", "_"))+") ",colorMap.get(preNodeState_results[i].replaceAll(" ", "_")),""));		
			paletteMap.put(preNodeState_results[i].replaceAll(" ", "_"), preNodeState_results[i]);
		}
		for(int i=0;i<nextNodeOrderIds.length;i++ ){			
			if(nodeMap.containsKey(nextNodeOrderIds[i])) continue;
			nodeMap.put(nextNodeOrderIds[i], this.createNode(g,nextNodeJobNames[i]+"\n ("+statusMap.get(nextNodeState_results[i].replaceAll(" ", "_"))+") ",colorMap.get(nextNodeState_results[i].replaceAll(" ", "_")),""));
			paletteMap.put(nextNodeState_results[i].replaceAll(" ", "_"), nextNodeState_results[i]);
		}
		
		
		for(int i=0;i<preNodeOrderIds.length;i++ ){
			if( !"NULL".equals(preNodeRefOrderIds[i]) ){
				g.addEdge(nodeMap.get(preNodeRefOrderIds[i]),nodeMap.get(preNodeOrderIds[i]));				
			}
		}
		for(int i=0;i<nextNodeOrderIds.length;i++ ){
			if( !"NULL".equals(nextNodeRefOrderIds[i]) ){
				g.addEdge(nodeMap.get(nextNodeOrderIds[i]), nodeMap.get(nextNodeRefOrderIds[i]));				
			}
		}
		
		m_vis.addGraph(GRAPH, g);
		
		return paletteMap;
    }
    
	private Node createNode(Graph g, String label, String gender, String toolTip) {
		Node node = g.addNode();
		node.setString(LABEL, label);
		node.setString(GENDER, gender);
		node.setString(TOOLTIP, toolTip);
		
		return node;
	}

	private Point2D getDisplayCenter(){
		return new Point2D.Float( getWidth() / 2,getHeight() / 2 );
	}

	public static JPanel panel(JobGraph sag, final String label) {		
		// create a new radial tree view
		
		Visualization vis = sag.getVisualization();
		
		// create a search panel for the tree map
		SearchQueryBinding sq = new SearchQueryBinding((Table)vis.getGroup(NODES), label, (SearchTupleSet)vis.getGroup(Visualization.SEARCH_ITEMS));
		JSearchPanel search = sq.createSearchPanel();
		search.setShowResultCount(true);
		search.setBorder(BorderFactory.createEmptyBorder(5,5,4,0));
		//search.setFont(FontLib.getFont("Tahoma", Font.PLAIN, 11));
		
		final JFastLabel title = new JFastLabel("				 ");
		title.setPreferredSize(new Dimension(350, 20));
		title.setVerticalAlignment(SwingConstants.BOTTOM);
		title.setBorder(BorderFactory.createEmptyBorder(3,0,0,0));
		//title.setFont(FontLib.getFont("Tahoma", Font.PLAIN, 16));
		
		
		Box box = new Box(BoxLayout.X_AXIS);
		box.add(Box.createHorizontalStrut(10));
		box.add(title);
		box.add(Box.createHorizontalGlue());
		box.add(search);
		box.add(Box.createHorizontalStrut(3));
		
		JPanel panel = new JPanel(new BorderLayout());
		panel.add(sag, BorderLayout.CENTER);
		panel.add(box, BorderLayout.SOUTH);
		
		Color BACKGROUND = Color.WHITE;
		Color FOREGROUND = Color.DARK_GRAY;
		UILib.setColor(panel, BACKGROUND, FOREGROUND);
		
		return panel;
	}
	
} 

