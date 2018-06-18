var BaseDao=require('./BaseDao');

//权限相关dao
var AuthDao=function(){

};
//获取所有权限资源
AuthDao.getUserAuthRes=function(resultCallback){
    var sql="select t4.account_id,t5.user_name,t1.resource_id,t1.resource_key," +
        "t1.resource_name,t1.resource_url from denglier_base_resource t1 " +
        "join denglier_base_resource_link_role t2 on t1.resource_id=t2.resource_id " +
        "join denglier_base_role t3 on t2.role_id=t3.role_id and t3.`enable`=1 " +
        "join denglier_base_account_link_role t4 on t3.role_id=t4.role_id " +
        "join denglier_base_account t5 on t4.account_id=t5.account_id " +
        "where t1.`enable`=1  ";
    console.log("AuthDao.userAuthRes sql>>>"+sql);
    BaseDao.select(sql,null,resultCallback);
};

//获取所有非权限资源
AuthDao.getUnauthRes=function(resultCallback){
    var sql="select id,unauth_name,url from denglier_base_unauth_resource";
    console.log("AuthDao.getUnauthRes sql>>>"+sql);
    BaseDao.select(sql,null,resultCallback);
};

module.exports = AuthDao;


/**
 * 根据用户名获取密码
 */
AuthDao.getPwdByUsername=function(username,resultCallback){
    var sql="select pwd from denglier_base_account where user_name=? ";
    console.log("AuthDao.getPwdByUsername sql>>>"+sql);
    var params=[username];
    console.log("AuthDao.getPwdByUsername params>>>"+params);
    BaseDao.select(sql,params,resultCallback);
};

/**
 * 存储toke日志信息
 */
AuthDao.insertTokenLog=function(token,username,resultCallback){
    var sql="insert into denglier_base_token_log(token,user_name)values(?,?)";
    console.log("AuthDao.insertTokenLog sql>>>"+sql);
    var params=[token,username];
    console.log("AuthDao.insertTokenLog params>>>"+params);
    BaseDao.select(sql,params,resultCallback);
};

/**
 * 记录token 访问次数，激发mysql自动记录更新时间刷新token过期时间
 */
AuthDao.updateTokenVisitNum=function(token){
    var sql="update denglier_base_token_log set visit_num=visit_num+1 where token=? ";
    BaseDao.update(sql,[token],function(data){});
};

/**
 * 根据token获取用户名，检测token是否有效
 */
AuthDao.getUsernameAndValidToken=function(token,resultCallback){
    var sql="select ifnull(t1.user_name,'')username from denglier_base_token_log t1 " +
        "join denglier_base_account t2 on t1.user_name=t2.user_name " +
        "where t1.token=? " +
        "and date_add(t1.update_time,interval (select config_value from denglier_base_system_config where config_key='token_valid_minute') minute)>now() ";
    BaseDao.select(sql,[token],resultCallback);
};





