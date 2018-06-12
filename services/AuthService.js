var md5 = require("blueimp-md5");
var AuthService=function(){};

AuthService.test=function(){
    return "AuthService test>>>";
};

/**
 * 登录系统
 * @return 登录成功返回token，失败返回失败信息
 */
AuthService.login=function(){

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











