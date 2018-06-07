var UserInfoPo=function(data){
    //caId 用户编号
    this.caId=data.caId;
    //用户账号
    this.account=data.account;
    //用户姓名
    this.name=data.name;
    //创建时间
    this.createTime=data.createTime;
    //基地code
    this.instituteNumber=data.instituteNumber;
    Object.freeze(this);
};

module.exports = UserInfoPo;