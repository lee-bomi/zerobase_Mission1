package com.quest.mission1.db;

import com.quest.mission1.entity.History;
import com.quest.mission1.entity.WifiInfo;
import com.quest.mission1.entity.WifiList;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class WifiService {
    public List<WifiList> getList() {
        String url = "jdbc:sqlite:D:\\zerobase\\mission1\\sqlite.db";
        Connection connection = null;
        Statement statement = null;
        PreparedStatement preparedStatement = null;
        ResultSet rs = null;
        List<WifiList> infos = new ArrayList<>();

        try {
            Class.forName("org.sqlite.JDBC");   //1. 드라이버 로드 (예외처리 필수, 감당안되면 throws하기, 감당되면 try catch로 처리)
        } catch (ClassNotFoundException e) {
            throw new RuntimeException(e);
        }

        try {
            String sql = "select * from wifi_info ORDER BY DISTANCE ASC limit 20";
            connection = DriverManager.getConnection(url);    //2. 커넥션객체생성
            preparedStatement = connection.prepareStatement(sql);         //3. 스테이트먼터객체 실행
//            statement = connection.createStatement();         //3. 스테이트먼터객체 실행
            rs = preparedStatement.executeQuery();                 //4. 쿼리실행
            while (rs.next()) {
                WifiList info = new WifiList();
                info.setX_SWIFI_MGR_NO(rs.getString("MGR_NO"));
                info.setX_SWIFI_WRDOFC(rs.getString("WRDOFC"));
                info.setX_SWIFI_MAIN_NM(rs.getString("MAIN_NM"));
                info.setX_SWIFI_ADRES1(rs.getString("ADRES1"));
                info.setX_SWIFI_ADRES2(rs.getString("ADRES2"));
                info.setX_SWIFI_INSTL_FLOOR(rs.getString("INSTL_FLOOR"));
                info.setX_SWIFI_INSTL_TY(rs.getString("INSTL_TY"));
                info.setX_SWIFI_INSTL_MBY(rs.getString("INSTL_MBY"));
                info.setX_SWIFI_SVC_SE(rs.getString("SVC_SE"));
                info.setX_SWIFI_CMCWR(rs.getString("CMCWR"));
                info.setX_SWIFI_CNSTC_YEAR(rs.getString("CNSTC_YEAR"));
                info.setX_SWIFI_INOUT_DOOR(rs.getString("INOUT_DOOR"));
                info.setX_SWIFI_REMARS3(rs.getString("REMARS3"));
                info.setLAT(rs.getString("LAT"));
                info.setLNT(rs.getString("LNT"));
                info.setWORK_DTTM(rs.getString("WORK_DTTM"));
                info.setDISTANCE(rs.getDouble("DISTANCE"));

                infos.add(info);
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        } finally {
            try {
                if (rs != null) {
                    rs.close();
                }
            } catch (SQLException e) {
                e.printStackTrace();
            }
            try {
                if (statement != null) {
                    statement.close();
                }
            } catch (SQLException e) {
                e.printStackTrace();
            }
            try {
                if (connection != null) {
                    connection.close();
                }
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
        return infos;
    }
    //거리가 가까운순으로 20개만 뽑아온다
    public List<WifiList> getListIncludeDistance() {
        String url = "jdbc:sqlite:D:\\zerobase\\mission1\\sqlite.db";
//        String url = "jdbc:sqlite:sqlite.db";
        Connection connection = null;
        Statement statement = null;
        PreparedStatement preparedStatement = null;
        ResultSet rs = null;
        List<WifiList> wifiLists = new ArrayList<>();

        try {
            Class.forName("org.sqlite.JDBC");   //1. 드라이버 로드 (예외처리 필수, 감당안되면 throws하기, 감당되면 try catch로 처리)
        } catch (ClassNotFoundException e) {
            throw new RuntimeException(e);
        }

        try {
            String sql = "select * from wifi_list_include_distance order by DISTANCE asc LIMIT 20";
            connection = DriverManager.getConnection(url);              //2. 커넥션객체생성
            preparedStatement = connection.prepareStatement(sql);         //3. 스테이트먼터객체 실행
            rs = preparedStatement.executeQuery();                      //4. 쿼리실행
            while (rs.next()) {
                WifiList list = new WifiList();
                list.setDISTANCE(rs.getFloat("DISTANCE"));
                list.setX_SWIFI_MGR_NO(rs.getString("MGR_NO"));
                list.setX_SWIFI_WRDOFC(rs.getString("WRDOFC"));
                list.setX_SWIFI_MAIN_NM(rs.getString("MAIN_NM"));
                list.setX_SWIFI_ADRES1(rs.getString("ADRES1"));
                list.setX_SWIFI_ADRES2(rs.getString("ADRES2"));
                list.setX_SWIFI_INSTL_FLOOR(rs.getString("INSTL_FLOOR"));
                list.setX_SWIFI_INSTL_TY(rs.getString("INSTL_TY"));
                list.setX_SWIFI_INSTL_MBY(rs.getString("INSTL_MBY"));
                list.setX_SWIFI_SVC_SE(rs.getString("SVC_SE"));
                list.setX_SWIFI_CMCWR(rs.getString("CMCWR"));
                list.setX_SWIFI_CNSTC_YEAR(rs.getString("CNSTC_YEAR"));
                list.setX_SWIFI_INOUT_DOOR(rs.getString("INOUT_DOOR"));
                list.setX_SWIFI_REMARS3(rs.getString("REMARS3"));
                list.setLAT(rs.getString("LAT"));
                list.setLNT(rs.getString("LNT"));
                list.setWORK_DTTM(rs.getString("WORK_DTTM"));

                wifiLists.add(list);
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        } finally {
            try {
                if (rs != null) {
                    rs.close();
                }
            } catch (SQLException e) {
                e.printStackTrace();
            }
            try {
                if (statement != null) {
                    statement.close();
                }
            } catch (SQLException e) {
                e.printStackTrace();
            }
            try {
                if (connection != null) {
                    connection.close();
                }
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
        return wifiLists;
    }

    //history list를 가져온다
    public List<History> getHistoryList() {
        String url = "jdbc:sqlite:D:\\zerobase\\mission1\\sqlite.db";
        Connection connection = null;
        Statement statement = null;
        PreparedStatement preparedStatement = null;
        ResultSet rs = null;
        List<History> historyList = new ArrayList<>();

        try {
            Class.forName("org.sqlite.JDBC");   //1. 드라이버 로드 (예외처리 필수, 감당안되면 throws하기, 감당되면 try catch로 처리)
        } catch (ClassNotFoundException e) {
            throw new RuntimeException(e);
        }

        try {
            String sql = "select * from history";
            connection = DriverManager.getConnection(url);              //2. 커넥션객체생성
            preparedStatement = connection.prepareStatement(sql);         //3. 스테이트먼터객체 실행
            rs = preparedStatement.executeQuery();                      //4. 쿼리실행
            while (rs.next()) {
                History history = new History();
                history.setID(rs.getInt("ID"));
                history.setLNT(rs.getFloat("LNT_X"));
                history.setLAT(rs.getFloat("LAT_Y"));
                history.setCURTIME(rs.getString("CURTIME"));
                historyList.add(history);
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        } finally {
            try {
                if (rs != null) {
                    rs.close();
                }
            } catch (SQLException e) {
                e.printStackTrace();
            }
            try {
                if (statement != null) {
                    statement.close();
                }
            } catch (SQLException e) {
                e.printStackTrace();
            }
            try {
                if (connection != null) {
                    connection.close();
                }
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
        return historyList;
    }
    public int dbInsert(WifiInfo[] list, String lntVal, String latVal) {
        String url = "jdbc:sqlite:D:\\zerobase\\mission1\\sqlite.db";
        Connection connection = null;
        PreparedStatement preparedStatement = null;
        ResultSet rs = null;
        Statement statement = null;
        int affectedRows = 0;
        double lnt = Double.parseDouble(lntVal);
        double lat = Double.parseDouble(latVal);

        try {
            Class.forName("org.sqlite.JDBC");   //1. 드라이버 로드 (예외처리 필수, 감당안되면 throws하기, 감당되면 try catch로 처리)
        } catch (ClassNotFoundException e) {
            throw new RuntimeException(e);
        }

        for (WifiInfo wifiInfo : list) {
            try {
                connection = DriverManager.getConnection(url);   //2. 커넥션객체생성
                String sql = "insert or replace into wifi_info (" +     //db에 같은 mgr_no값이 있다면 대체해주는 쿼리(MGR_NO = unique key처리
                        "MGR_NO, WRDOFC, MAIN_NM, ADRES1, ADRES2, INSTL_FLOOR, INSTL_TY, INSTL_MBY, SVC_SE, CMCWR, CNSTC_YEAR, INOUT_DOOR, REMARS3, LAT, LNT, WORK_DTTM, DISTANCE) " +
                        "values (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
                preparedStatement = connection.prepareStatement(sql);
                //distance추가?
                double _lat = Double.parseDouble(wifiInfo.getLAT());
                double _lnt = Double.parseDouble(wifiInfo.getLNT());
                double x = Math.pow(lnt - _lnt, 2);
                double y = Math.pow(lat - _lat, 2);
                double distance = Math.sqrt(x + y);
                preparedStatement.setString(1, wifiInfo.getX_SWIFI_MGR_NO());
                preparedStatement.setString(2, wifiInfo.getX_SWIFI_WRDOFC());
                preparedStatement.setString(3, wifiInfo.getX_SWIFI_MAIN_NM());
                preparedStatement.setString(4, wifiInfo.getX_SWIFI_ADRES1());
                preparedStatement.setString(5, wifiInfo.getX_SWIFI_ADRES2());
                preparedStatement.setString(6, wifiInfo.getX_SWIFI_INSTL_FLOOR());
                preparedStatement.setString(7, wifiInfo.getX_SWIFI_INSTL_TY());
                preparedStatement.setString(8, wifiInfo.getX_SWIFI_INSTL_MBY());
                preparedStatement.setString(9, wifiInfo.getX_SWIFI_SVC_SE());
                preparedStatement.setString(10, wifiInfo.getX_SWIFI_CMCWR());
                preparedStatement.setString(11, wifiInfo.getX_SWIFI_CNSTC_YEAR());
                preparedStatement.setString(12, wifiInfo.getX_SWIFI_INOUT_DOOR());
                preparedStatement.setString(13, wifiInfo.getX_SWIFI_REMARS3());
                preparedStatement.setString(14, wifiInfo.getLAT());
                preparedStatement.setString(15, wifiInfo.getLNT());
                preparedStatement.setString(16, wifiInfo.getWORK_DTTM());
                preparedStatement.setDouble(17, distance);

                affectedRows = preparedStatement.executeUpdate();
            } catch (SQLException e) {
                throw new RuntimeException(e);
            } finally {
                try {
                    if (preparedStatement != null) {
                        preparedStatement.close();
                    }
                } catch (SQLException e) {
                    e.printStackTrace();
                }
                try {
                    if (!connection.isClosed()) {
                        connection.close();
                    }
                } catch (SQLException e) {
                    e.printStackTrace();
                }
            }
        }
        return affectedRows;
    }

    public int historyInsert(History history) {
        String url = "jdbc:sqlite:D:\\zerobase\\mission1\\sqlite.db";
        Connection connection = null;
        PreparedStatement preparedStatement = null;
        ResultSet rs = null;
        Statement statement = null;
        int affectedRows = 0;

        try {
            Class.forName("org.sqlite.JDBC");   //1. 드라이버 로드 (예외처리 필수, 감당안되면 throws하기, 감당되면 try catch로 처리)
        } catch (ClassNotFoundException e) {
            throw new RuntimeException(e);
        }


        try {
            connection = DriverManager.getConnection(url);   //2. 커넥션객체생성
            String sql = "insert or replace into history (" +     //db에 같은 mgr_no값이 있다면 대체해주는 쿼리(MGR_NO = unique key처리
                    "LNT_X, LAT_Y, CURTIME) " +
                    "values (?, ?, ?)";
            preparedStatement = connection.prepareStatement(sql);
            preparedStatement.setDouble(1, history.getLNT());
            preparedStatement.setDouble(2, history.getLAT());
            preparedStatement.setString(3, history.getCURTIME());

            affectedRows = preparedStatement.executeUpdate();
            System.out.println(affectedRows + " : affectRow222222");
        } catch (SQLException e) {
            throw new RuntimeException(e);
        } finally {
            try {
                if (preparedStatement != null) {
                    preparedStatement.close();
                }
            } catch (SQLException e) {
                e.printStackTrace();
            }
            try {
                if (!connection.isClosed()) {
                    connection.close();
                }
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
        return affectedRows;
    }

    public void dbUpdate() {
        String url = "jdbc:sqlite:sqlite.db";
        Connection connection = null;
        PreparedStatement preparedStatement = null;
        ResultSet rs = null;

        int id = 2;
        String name = "임오구";

        try {
            Class.forName("org.sqlite.JDBC");   //1. 드라이버 로드 (예외처리 필수, 감당안되면 throws하기, 감당되면 try catch로 처리)
        } catch (ClassNotFoundException e) {
            throw new RuntimeException(e);
        }

        try {
            connection = DriverManager.getConnection(url);   //2. 커넥션객체생성
            String sql = "update test set name = ? where id = ?";
            preparedStatement = connection.prepareStatement(sql);
            preparedStatement.setInt(2, id);
            preparedStatement.setString(1, name);
            int affectedRows = preparedStatement.executeUpdate();

            if (affectedRows > 0) System.out.println("update 성공 : " + affectedRows);
            else System.out.println("update 실패");
        } catch (SQLException e) {
            throw new RuntimeException(e);
        } finally {
            try {
                if (!preparedStatement.isClosed() && !preparedStatement.isClosed()) {
                    preparedStatement.close();
                }
            } catch (SQLException e) {
                e.printStackTrace();
            }
            try {
                if (!connection.isClosed()) {
                    connection.close();
                }
            } catch (SQLException e) {
                e.printStackTrace();
            }

        };
    }

    public void deleteHistory(int num) {
        String url = "jdbc:sqlite:D:\\zerobase\\mission1\\sqlite.db";
        Connection connection = null;
        PreparedStatement preparedStatement = null;
        ResultSet rs = null;

        try {
            Class.forName("org.sqlite.JDBC");   //1. 드라이버 로드 (예외처리 필수, 감당안되면 throws하기, 감당되면 try catch로 처리)
        } catch (ClassNotFoundException e) {
            throw new RuntimeException(e);
        }

        try {
            connection = DriverManager.getConnection(url);   //2. 커넥션객체생성
            String sql = "delete from history where id = ?";
            preparedStatement = connection.prepareStatement(sql);
            preparedStatement.setInt(1, num);
            int affectedRows = preparedStatement.executeUpdate();

            if (affectedRows > 0) System.out.println("delete 성공 : " + affectedRows);
            else System.out.println("delete 실패");
        } catch (SQLException e) {
            throw new RuntimeException(e);
        } finally {
            try {
                if (!preparedStatement.isClosed() && !preparedStatement.isClosed()) {
                    preparedStatement.close();
                }
            } catch (SQLException e) {
                e.printStackTrace();
            }
            try {
                if (!connection.isClosed()) {
                    connection.close();
                }
            } catch (SQLException e) {
                e.printStackTrace();
            }

        };
    }
}
