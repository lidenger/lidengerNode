var md5 = require("blueimp-md5");
var AuthDao=require('../dao/AuthDao');
var Result=require('../common/ResultPo');
var md5 = require("blueimp-md5");
var AuthService=function(){};

AuthService.test=function(){
    return "AuthService test>>>";
};


/**
 * 所有用户的权限资源
 * map<user_name,map<resource_url,resource_id>>
 */
var userAuthResMap=new Map();

/**
 * 非权限资源
 * map<id,url>
 */
var unauthResMap=new Map();


/**
 * 加载/重新加载所有用户资源
 */
var reloadAllUserAuthRes=function(){
    userAuthResMap=new Map();
    AuthDao.getUserAuthRes(function(result){
        if(!result||result.code==0)return;
        for(var i=0;i<result.data.length;i++){
            var userRes=result.data[i];
            var user_name=userRes.user_name;
            var resourceId=userRes.resource_id;
            var resourceUrl=userRes.resource_url;
            if(!resourceUrl||resourceUrl.length<2)continue;
            var resMap=userAuthResMap.get(user_name);
            if(!resMap){
                resMap=new Map();
                userAuthResMap.set(user_name,resMap);
            }
            resMap.set(resourceUrl,resourceId);
        }
    });
};
reloadAllUserAuthRes();

var reloadAllUnauthRes=function(){
    unauthResMap=new Map();
    AuthDao.getUnauthRes(function(result){
        if(!result||result.code==0)return;
        for(var i=0;i<result.data.length;i++){
            var unauth=result.data[i];
            unauthResMap.set(unauth.url,unauth.id);
        }
    });
};
reloadAllUnauthRes();

/**
 * 检测账号是否有权限
 * @param accountId  用户编号
 * @param resUrl 资源url
 * @return 是否拥有权限
 */
var isExistsUserAuth=function(accountId,resUrl){
    if(!userAuthResMap)return false;
    if(!userAuthResMap.get(accountId))return false;
    if(!userAuthResMap.get(accountId).get(resUrl))return false;
    return true;
};

/**
 * 检测资源是否为非权限资源
 */
var isExistsUnauth=function(resUrl){
    if(unauthResMap.get(resUrl))
        return true;
    else
        return false;
};

/**
 * 所有请求过滤
 */
AuthService.auth=function(req,res,next){
    var url=req.originalUrl;
    var indexNum=url.indexOf("?");
    if(indexNum>0){
        url=url.substring(0,indexNum);
    }
    if(isExistsUnauth(url)){
        next();
        return;
    }
    var token=req.query.token;
    if(!token){
        res.send(Result.noToken());
        return;
    }
    AuthDao.getUsernameAndValidToken(token,function(result){
        if(!result||!result.data||result.data.length<1){
            res.send(Result.invalidToken());
            return;
        }
        var username=result.data[0].username;
        if(!username){
            res.send(Result.invalidToken());
            return;
        }
        var hasAuth=isExistsUserAuth(username,url);
        console.log("auth route url>>>"+url+",hasAuth:"+hasAuth+",username:"+username);
        if(hasAuth){
            AuthDao.updateTokenVisitNum(token);
            next();
        }else{
            res.send(Result.notAuth());
        }
    });

};


/**
 * 登录系统
 * @return 登录成功返回token，失败返回失败信息
 */
AuthService.login=function(loginPo,resultCallback){
    if(!loginPo.username||!loginPo.pwd){
        resultCallback(Result.paramsErr());
        return;
    }
    AuthDao.getPwdByUsername(loginPo.username,function(result){
        var dbpwd=result.data[0].pwd;
        if(loginPo.pwdmd5==dbpwd){//登录成功
            var token=md5(loginPo.username+loginPo.pwdmd5+(new Date().getTime()));
            AuthDao.insertTokenLog(token,loginPo.username,function(data){});
            resultCallback(new Result(1,{"token":token},Result.TYPE_AUTH));
        }else{
            resultCallback(new Result(0,{token:""},Result.TYPE_AUTH));
        }
    });
};

/**
 * 退出系统
 * @param token
 * @return 是否退出成功
 */
AuthService.logout=function(token){

};

/**
 * 用户注册
 */
AuthService.register=function(){

};

/**
 * 检测token是否有效
 * @param token
 * @return 是否有效（1有效，0无效）
 */
AuthService.isValidToken=function(token){

};

/**
 * 检测token是否有权限(token和user绑定实际上是验证用户是否有权限)
 * @param token
 * @param url 请求url
 * @return 是否有权限（1有权限，0无权限）
 */
AuthService.isAuthToken=function(token,url){

};

/**
 * 验证用户是否权限
 * @param userId
 * @param url 请求url
 * @return 是否有权限（1有权限，0无权限）
 */
AuthService.isAuthAccountId=function(accountId,url){

};

module.exports = AuthService;









