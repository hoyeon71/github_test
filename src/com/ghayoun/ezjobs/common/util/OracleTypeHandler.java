package com.ghayoun.ezjobs.common.util;

import java.sql.*;

// Referenced classes of package com.ibatis.sqlmap.engine.type:
//            BaseTypeHandler, TypeHandler

public class OracleTypeHandler extends com.ibatis.sqlmap.engine.type.BaseTypeHandler
    implements com.ibatis.sqlmap.engine.type.TypeHandler
{

    public OracleTypeHandler()
    {
    }

    public void setParameter(PreparedStatement ps, int i, Object parameter, String jdbcType)
        throws SQLException
    {
    	if( parameter instanceof String ) parameter = CommonUtil.K2E((String)parameter);
        ps.setObject(i,parameter);
    }

    public Object getResult(ResultSet rs, String columnName)
        throws SQLException
    {
        Object object = rs.getObject(columnName);
        
        //if( object instanceof String ) object = CommonUtil.E2K((String)object);
        if(rs.wasNull())
            return null;
        else
            return object;
    }

    public Object getResult(ResultSet rs, int columnIndex)
        throws SQLException
    {
        Object object = rs.getObject(columnIndex);
        
        if( object instanceof String ) object = CommonUtil.E2K((String)object);
        if(rs.wasNull())
            return null;
        else
            return object;
    }

    public Object getResult(CallableStatement cs, int columnIndex)
        throws SQLException
    {
        Object object = cs.getObject(columnIndex);
        
        if( object instanceof String ) object = CommonUtil.E2K((String)object);
        if(cs.wasNull())
            return null;
        else
            return object;
    }

    public Object valueOf(String s)
    {
        return s;
    }
}

