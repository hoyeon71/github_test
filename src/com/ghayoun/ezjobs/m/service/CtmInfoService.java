package com.ghayoun.ezjobs.m.service;

import java.io.Serializable;
import java.util.List;
import java.util.Map;

import com.ghayoun.ezjobs.comm.domain.*;
import com.ghayoun.ezjobs.m.domain.*;


public interface CtmInfoService extends Serializable{
    
    public List<CtmInfoBean> dGetAgentList(Map map);
    
    public CommonBean dGetJobCondListCnt(Map map);    
    
    public List<CtmInfoBean> dGetJobCondList(Map map);
    
    public List<CommonBean> dGetCmsNodGrpList(Map map);
    
    public List<CommonBean> dGetCmsNodGrpNodeList(Map map);
    
}
