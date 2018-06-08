var AuthDao=require('../dao/AuthDao');
var Result=require('../common/ResultPo');
//权限管理
var Auth=function(){

};
/**
 * map<accountId,map<resource_url,resource_id>>
 */
var userAuthResMap=new Map();

/**
 * 加载/重新加载所有用户资源
 */
var reloadAllUserAuthRes=function(){
    userAuthResMap=new Map();
    AuthDao.getUserAuthRes(function(result){
        if(!result||result.code==0)return;
        for(var i=0;i<result.data.length;i++){
            var userRes=result.data[i];
            var accountId=userRes.account_id;
            var resourceId=userRes.resource_id;
            var resourceUrl=userRes.resource_url;
            if(!resourceUrl||resourceUrl.length<2)continue;
            var resMap=userAuthResMap.get(accountId);
            if(!resMap){
                resMap=new Map();
                userAuthResMap.set(accountId,resMap);
            }
            resMap.set(resourceUrl,resourceId);
        }
    });
};
reloadAllUserAuthRes();


/**
 * 检测账号是否有权限
 * @param accountId  用户编号
 * @param resUrl 资源url
 * @return 是否拥有权限
 */
var getUserAuthRes=function(accountId,resUrl){
    if(!userAuthResMap)return false;
    if(!userAuthResMap.get(accountId))return false;
    if(!userAuthResMap.get(accountId).get(resUrl))return false;
    return true;
};


Auth.auth=function(req,res,next){
    var url=req.originalUrl;
    var indexNum=url.indexOf("?");
    if(indexNum>0){
        url=url.substring(0,indexNum);
    }
    var accountId=req.query.accountId;
    var hasAuth=getUserAuthRes(parseInt(accountId),url);
    console.log("auth route url>>>"+url+",hasAuth:"+hasAuth+",accountId:"+accountId);
    if(!hasAuth)
        res.send(Result.notAuth());
    else
        next();
};

module.exports = Auth;












