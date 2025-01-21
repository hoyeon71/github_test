

import prefuse.util.ui.JPrefuseApplet;
import java.util.*;

public class JobGraphApplet extends JPrefuseApplet {

    public void init() {
    	Map<String,String> paramMap = new HashMap<String,String>();

		paramMap.put("preNodeOrderIds",getParameter("preNodeOrderIds"));
    	paramMap.put("preNodeRefOrderIds",getParameter("preNodeRefOrderIds"));
    	paramMap.put("preNodeJobNames",getParameter("preNodeJobNames"));
    	paramMap.put("preNodeState_results",getParameter("preNodeState_results"));
    	
    	paramMap.put("nextNodeOrderIds",getParameter("nextNodeOrderIds"));
    	paramMap.put("nextNodeRefOrderIds",getParameter("nextNodeRefOrderIds"));
    	paramMap.put("nextNodeJobNames",getParameter("nextNodeJobNames"));
    	paramMap.put("nextNodeState_results",getParameter("nextNodeState_results"));
    	
    	this.setContentPane(JobGraph.panel(new JobGraph(paramMap),"label"));        
    }
    
}