//权限管理
var Auth=function(){

};

Auth.auth=function(req,res,next){
    var url=req.originalUrl;
    var indexNum=url.indexOf("?");
    if(indexNum>0){
        url=url.substring(0,indexNum);
    }
    console.log("auth route url>>>"+url);
    next();
};

module.exports = Auth;












