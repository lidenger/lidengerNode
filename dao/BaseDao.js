var mysql=require('mysql');
var Result=require('../common/ResultPo');

/**
 *
 * @param sql
 * @param resultCallback 结果回调函数,用于接收查询结果,对象,null为查询失败
 */
var BaseDao=function(){};

var conn=mysql.createConnection({
    host:'127.0.0.1',
    user:'root',
    password:'6635',
    port:'3306',
    database:'lytest'
});
conn.connect();
BaseDao.test=function(){
    return "BaseDao test>>";
};

/**
 * 执行sql
 * @param sql sql语句，字符串
 * @param params sql参数，数组,无参数传null
 * @param resultCallback 结果回调函数,用于接收查询结果,对象,null为查询失败
 * @param type 操作类型
 */
var executeSql=function(sql,params,resultCallback,type){
    conn.query(sql,params,function(err,result){
        if(err)
            resultCallback(Result.failure(err,type));
        else
            resultCallback(Result.success(result,type));
    });
};

/**
 * 查询
 */
BaseDao.select=function(sql,params,resultCallback){
    executeSql(sql,params,resultCallback,Result.TYPE_SELECT);
};

/**
 * 修改
 */
BaseDao.update=function(sql,params,resultCallback){
    executeSql(sql,params,resultCallback,Result.TYPE_UPDATE);
};

/**
 * 删除
 */
BaseDao.delete=function(sql,params,resultCallback){
    executeSql(sql,params,resultCallback,Result.TYPE_DELETE);
};

/**
 * 新增
 */
BaseDao.insert=function(sql,params,resultCallback){
    executeSql(sql,params,resultCallback,Result.TYPE_INSERT);
};


module.exports = BaseDao;




