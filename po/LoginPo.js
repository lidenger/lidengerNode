var md5 = require("blueimp-md5");
/**
 * 登录实体对象
 */
var LoginPo=function(data){
    //用户名
    this.username=data.username;
    //密码
    this.pwd=data.pwd;
    //md5密码
    this.pwdmd5=md5(data.pwd);
    Object.freeze(this);
};


module.exports = LoginPo;
