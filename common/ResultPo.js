var Result=function(code,data,type){
    this.code=code;
    this.data=data;
    this.type=type;
    Object.freeze(this);
};

//操作失败
Result.FAILURE=0;
//操作成功
Result.SUCCESS=1;
//权限不足或资源不存在
Result.NOT_AUTH=-1;
//操作类型-查询
Result.TYPE_SELECT=1;
//操作类型-删除
Result.TYPE_DELETE=2;
//操作类型-更新
Result.TYPE_UPDATE=3;
//操作类型-新增
Result.TYPE_INSERT=4;
//操作类型-未知
Result.TYPE_UNKNOWN=-1;


Result.failure=function(msg,type){
    return new Result(Result.FAILURE,msg,type);
};

Result.success=function(data,type){
    return new Result(Result.SUCCESS,data,type);
};

Result.notAuth=function(){
    return new Result(Result.NOT_AUTH,"权限不足或资源不存在",Result.TYPE_UNKNOWN);
};

module.exports = Result;
