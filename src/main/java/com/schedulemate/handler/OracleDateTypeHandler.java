package com.schedulemate.handler;

import java.sql.CallableStatement;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Types;

import org.apache.ibatis.type.JdbcType;
import org.apache.ibatis.type.TypeHandler;

public class OracleDateTypeHandler implements TypeHandler<Date> {

	@Override
	public void setParameter(PreparedStatement ps, int i, Date parameter, JdbcType jdbcType) throws SQLException {
		if (parameter != null) {
			ps.setDate(i, parameter);
		} else {
			ps.setNull(i, Types.DATE);
		}
	}

	@Override
	public Date getResult(ResultSet rs, String columnName) throws SQLException {
		java.sql.Date date = rs.getDate(columnName);
		if (date != null) {
			return new Date(date.getTime());
		}
		return null;
	}

	@Override
	public Date getResult(ResultSet rs, int columnIndex) throws SQLException {
		java.sql.Date date = rs.getDate(columnIndex);
		if (date != null) {
			return new Date(date.getTime());
		}
		return null;
	}

	@Override
	public Date getResult(CallableStatement cs, int columnIndex) throws SQLException {
		java.sql.Date date = cs.getDate(columnIndex);
		if (date != null) {
			return new Date(date.getTime());
		}
		return null;
	}

}