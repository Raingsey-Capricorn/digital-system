create table if not exists t_account
(
    id                           bigint                                   not null comment '主键ID',
    user_id                      bigint                                   null comment '用户ID',
    type                         tinyint(2)     default 1                 null comment '类型',
    balance_income_amount        decimal(18, 2) default 0.00              null comment '总收入',
    balance_expense_amount       decimal(18, 2) default 0.00              null comment '总支出',
    available_balance            decimal(18, 2) default 0.00              null comment '可用彩金',
    money_balance                decimal(10, 2) default 0.00              null comment '可用现金',
    balance_money_income_amount  decimal(10, 2) default 0.00              null comment '总现金收入',
    balance_money_expense_amount decimal(10, 2) default 0.00              null comment '总现金支出',
    brokerage_income_amount      decimal(18, 2) default 0.00              null comment '佣金',
    brokerage_expense_amount     decimal(18, 2) default 0.00              null comment '佣金支出',
    withdraw_count               int(10)        default 0                 null comment '提现次数',
    total_withdraw_amount        decimal(18, 2) default 0.00              null comment '总提现',
    total_exchange_amount        decimal(18, 2) default 0.00              null comment '总兑换',
    available_brokerage          decimal(18, 2) default 0.00              null comment '佣金余额',
    freeze_balance_amount        decimal(18, 2) default 0.00              null comment '冻结彩金',
    freeze_money_amount          decimal(10, 2) default 0.00              null comment '冻结现金',
    freeze_brokerage_amount      decimal(18, 2) default 0.00              null comment '冻结佣金',
    settlement_type              tinyint(2)                               null comment '1-月结模式；2:日结模式',
    total_score                  int(10)        default 0                 null comment '总积分',
    available_score              int(10)        default 0                 null comment '可用积分(月初清零)',
    recharge_count               int            default 0                 null comment '充值次数',
    total_recharge_amount        decimal(10, 2) default 0.00              null comment '总充值金额',
    max_recharge_amount          decimal(10, 2) default 0.00              null comment '最大充值金额',
    recharge_company_bank_amount decimal(10, 2) default 0.00              null comment '公司入款总额',
    recharge_on_line_amount      decimal(10, 2) default 0.00              null comment '在线充值总额',
    recharge_by_manual_amount    decimal(10, 2) default 0.00              null comment '人工存入总额',
    recharge_by_exchange_amount  decimal(10, 2) default 0.00              null comment '兑换充值总额',
    last_recharge_time           datetime                                 null comment '上次充值时间',
    total_promote_amount         decimal(10, 2) default 0.00              null comment '推广总福利金',
    sync_status                  tinyint(2)     default 1                 null comment '同步状态',
    status                       tinyint(2)     default 1                 not null comment '账户状态，1-正常，0-冻结',
    create_time                  timestamp      default CURRENT_TIMESTAMP not null comment '创建时间',
    update_time                  timestamp      default CURRENT_TIMESTAMP not null on update CURRENT_TIMESTAMP comment '修改时间',
    primary key (id)
)
    charset = utf8mb4;

create table if not exists t_account_detail
(
    id                      bigint auto_increment comment '主键ID'
        primary key,
    user_id                 bigint                               null comment '用户ID',
    related_id              bigint                               null comment '关联ID',
    order_no                varchar(50)                          null comment '订单号',
    payment_type            tinyint(2)                           null comment '收支类型(-1：支出，1：收入，0：非收支记录)',
    amount                  decimal(18, 2)                       null comment '金额',
    available_balance       decimal(18, 2)                       null comment '当前余额',
    freeze_amount           decimal(18, 2)                       null comment '收支',
    trade_type              tinyint(2)                           null comment '1-注册红包，2-填写邀请码，3-拉新，4-二级拉新，5-分享红包，6-日常红包，7-至尊用户每月津贴，8-至尊用户奖励,9-提现，16-每日助力',
    item_type               tinyint(2) default 1                 null comment '1-彩金，2-现金',
    status                  tinyint(2) default 1                 not null comment '状态(1-到账，2-冻结,3-取消)',
    remark                  varchar(500)                         null comment '备注',
    send_red_packet_user_id bigint                               null comment '发红包用户id',
    create_time             timestamp  default CURRENT_TIMESTAMP not null comment '创建时间',
    update_time             timestamp  default CURRENT_TIMESTAMP not null comment '修改时间',
    constraint order_no
        unique (order_no)
)
    charset = utf8mb4;

create index index1
    on t_account_detail (user_id);

create index index2
    on t_account_detail (create_time);

create index index3
    on t_account_detail (trade_type);

create table if not exists t_activity
(
    id                   bigint auto_increment
        primary key,
    name                 varchar(128)                           not null comment '活动名称',
    description          varchar(256)                           not null comment '活动描述',
    type                 tinyint(2)   default 2                 not null comment '活动类型，1-日常活动，2-任务活动',
    sub_type             tinyint(3)   default 100               not null comment '活动子类型，100-普通活动，101-组合活动',
    reward               decimal(6, 2)                          null comment '奖励',
    comment_count        int          default 0                 null comment '评论数',
    commented_count      int          default 0                 null comment '被评论数',
    collect_count        int          default 0                 null comment '收藏数',
    concern_count        int          default 0                 null comment '关注数',
    thumb_up_count       int          default 0                 null comment '点赞数',
    fans_count           int          default 0                 null comment '粉丝数',
    acquire_thumb_count  int          default 0                 null comment '获赞数',
    report_count         int          default 0                 null comment '举报数',
    account_balance      decimal(8, 2)                          null comment '账号余额',
    send_red_packet      decimal(8, 2)                          null comment '发送红包金额',
    click_count          int          default 0                 null comment '查看数',
    share_count          int          default 0                 null comment '分享数',
    help_count           int          default 0                 null comment '助力数',
    article_count        int          default 0                 null comment '发帖数',
    status               tinyint      default 1                 not null comment '状态，1-有效，0-无效',
    sort                 int          default 100               not null comment '排序，升序',
    display              tinyint(2)   default 1                 not null comment '是否展示在活动列表，0-不展示，1-展示',
    remark               varchar(256) default ''                null comment '备注',
    begin_time           datetime                               null comment '开始时间',
    end_time             datetime                               null comment '结束时间',
    button_name_begin    varchar(12)                            not null comment '开始按钮名称',
    button_name_received varchar(12)                            null comment '接受后按钮名称',
    button_name_finish   varchar(12)                            not null comment '完成后按钮名称',
    button_name_end      varchar(12)                            not null comment '领奖后按钮名称',
    create_time          datetime     default CURRENT_TIMESTAMP null,
    update_time          datetime                               null on update CURRENT_TIMESTAMP,
    constraint index1
        unique (name)
)
    charset = utf8mb4;

create table if not exists t_activity_condition
(
    id            bigint auto_increment comment '自增长ID'
        primary key,
    code          varchar(64)                         null comment 'code，该项活动的标示',
    name          varchar(32)                         null comment '名称',
    description   varchar(512)                        null comment '描述',
    amount        decimal   default 0                 not null comment '奖励金额',
    type          tinyint   default 1                 not null comment '类型：1-定时任务条件；2-活动条件',
    comment_count int       default 0                 not null comment '评论数',
    collect_count int       default 0                 not null comment '收藏数',
    concern_count int       default 0                 not null comment '关注数',
    thumbup_count int       default 0                 not null comment '点赞数',
    click_count   int       default 0                 not null comment '查阅数',
    share_count   int       default 0                 not null comment '分享数',
    sort          int       default 100               null comment '排序字段，正序',
    remark        varchar(256)                        null comment '备注',
    status        tinyint   default 1                 not null comment '有效状态',
    create_time   timestamp default CURRENT_TIMESTAMP not null comment '创建时间',
    update_time   timestamp default CURRENT_TIMESTAMP not null on update CURRENT_TIMESTAMP comment '更新时间'
)
    comment '活动条件表' charset = utf8mb4;

create table if not exists t_advert
(
    id                  bigint auto_increment comment '自增长ID'
        primary key,
    lottery_type        tinyint(2) default 2                 null comment '1-香港，2-澳门，3-台湾',
    xg_type             tinyint(2) default 1                 null comment '1-amtk，2-mh',
    user_id             bigint                               null comment '用户ID，创建者ID',
    name                varchar(256)                         null comment '广告的名称',
    content_type        tinyint(2) default 1                 null comment '内容格式，1-图片，2-超文本',
    description         longtext                             null comment '广告文本内容',
    url                 varchar(256)                         null comment '广告的链接',
    web_browser         tinyint(2) default 1                 null comment '是否跳转浏览器，0:不跳，1:跳',
    is_to_bet           tinyint(2) default 0                 null comment '(0-不跳，1-跳购彩，2-跳活动中心)',
    remark              varchar(256)                         null comment '备注',
    type                tinyint(2) default 1                 null comment '1-首页广告，2-个人中心,3-计数弹框，4-不计数弹框',
    sub_type            tinyint(3)                           null comment '广告子类型',
    discount_type       tinyint(2)                           null comment '优惠活动类型 1:平台,2:六合彩,3:棋牌,4:捕鱼',
    status              tinyint(2) default 1                 not null comment '状态（0:无效；1:有效）',
    sort                int(4)     default 1                 null comment '排序',
    is_pop_index        tinyint(2) default 1                 null comment '首页是否弹',
    is_pop_game_list    tinyint(2) default 1                 null comment '游戏列表是否弹',
    is_pop_account_list tinyint(2) default 1                 null comment '充值账户列表是否弹',
    waiting_time        int(4)                               null comment '等待时间(启动)',
    create_time         timestamp  default CURRENT_TIMESTAMP not null comment '创建时间',
    update_time         timestamp  default CURRENT_TIMESTAMP not null on update CURRENT_TIMESTAMP comment '更新时间',
    game_id             bigint                               null comment '游戏ID',
    web_title           varchar(1024)                        null comment '网站广告标题',
    web_url             varchar(1024)                        null comment '网站广告链接'
)
    comment '广告表' charset = utf8mb4;

create table if not exists t_advert_read
(
    id          bigint auto_increment comment '主键ID'
        primary key,
    user_id     bigint                               null comment '用户ID',
    device_id   varchar(40)                          null comment '设备ID',
    related_id  bigint                               null comment '关联ID',
    type        tinyint(2) default 1                 null comment '1-首页广告，2-个人中心,3-计数弹框，4-不计数弹框',
    status      tinyint(2) default 1                 not null comment '状态(0-无效，1-有效)',
    create_time timestamp  default CURRENT_TIMESTAMP not null comment '创建时间',
    update_time timestamp  default CURRENT_TIMESTAMP not null comment '修改时间',
    constraint user_id
        unique (user_id, related_id)
)
    charset = utf8mb4;

create table if not exists t_advert_type
(
    id          bigint auto_increment comment 'id'
        primary key,
    name        varchar(64)                          not null comment '广告类型名字',
    type        tinyint(3)                           not null comment '类型值',
    width       int                                  not null comment '宽，单位px',
    height      int                                  not null comment '高，单位px',
    status      tinyint(2) default 1                 not null comment '状态，0-无效，1-有效',
    remark      varchar(256)                         null comment '备注',
    create_time datetime   default CURRENT_TIMESTAMP not null comment '创建时间',
    update_time datetime                             null on update CURRENT_TIMESTAMP comment '修改时间',
    constraint index1
        unique (name),
    constraint index2
        unique (type)
)
    charset = utf8mb4;

create table if not exists t_agent_apply
(
    id             bigint(16) auto_increment
        primary key,
    user_id        bigint(16)                           null comment '用户id',
    status         tinyint(2) default 2                 null comment '0 未通过,1 通过,2 审核中',
    reason         varchar(256)                         null comment '理由',
    varify_user_id bigint(16)                           null comment '审核人id',
    create_time    timestamp  default CURRENT_TIMESTAMP not null comment '创建时间，默认为当前',
    update_time    timestamp  default CURRENT_TIMESTAMP not null comment '修改时间，默认为当前'
)
    charset = utf8mb4;

create table if not exists t_agent_brokerage_record
(
    id              bigint                                   not null comment '使用提现或兑换ID作为主键',
    user_id         bigint                                   not null comment '用户id',
    withdraw_id     bigint                                   not null comment '提现ID',
    month           int(4)                                   null comment '月',
    amount          decimal(10, 2) default 0.00              null comment '金额',
    rate            decimal(10, 4) default 0.0000            null comment '返佣比例',
    original_amount decimal(10, 2) default 0.00              null comment '原始金额',
    from_user_id    bigint                                   null comment '提现人用户ID',
    status          tinyint(2)     default 0                 null comment '0-未到账，1-已到账，-1-取消',
    type            tinyint(2)                               null,
    create_time     timestamp      default CURRENT_TIMESTAMP null comment '创建时间',
    update_time     timestamp      default CURRENT_TIMESTAMP null on update CURRENT_TIMESTAMP comment '更新时间',
    primary key (id)
)
    charset = utf8mb4;

create index user_id
    on t_agent_brokerage_record (user_id, month);

create table if not exists t_agent_brokerage_stat
(
    id           bigint                                   not null comment 'yyyyMM + userId作为主键',
    user_id      bigint                                   null comment '用户id',
    month        int(4)                                   null comment '月',
    total_amount decimal(16, 2) default 0.00              null comment '返佣总金额',
    total_count  int(10)        default 0                 null comment '返佣总次数',
    create_time  timestamp      default CURRENT_TIMESTAMP null comment '创建时间',
    update_time  timestamp      default CURRENT_TIMESTAMP null comment '更新时间',
    primary key (id)
)
    charset = utf8mb4;

create index user_id
    on t_agent_brokerage_stat (user_id, month);

create table if not exists t_agent_condition
(
    id              bigint auto_increment
        primary key,
    content         varchar(512)                         null comment '内容(其中的变量依序对应入param_1,param_2,param_3,param_4)',
    param_1         varchar(16)                          null comment '参数1',
    param_2         varchar(16)                          null comment '参数2',
    param_3         varchar(16)                          null comment '参数3',
    param_4         varchar(16)                          null comment '参数4',
    rule_type       tinyint(2)                           null comment '1.申请门槛 2.享受福利 3.代言人基础标准 4.有效拉新用户 5.工资奖励机制 6.兑换彩金返佣准则',
    rule            varchar(256)                         null,
    rule_lower_type tinyint(2)                           null comment 'rule_type的下级type，备注于代码中',
    status          tinyint(2) default 1                 not null comment '是否生效（0否，1是）',
    sort            int(2)                               null comment '排序',
    create_time     timestamp  default CURRENT_TIMESTAMP not null comment '创建时间，默认为当前',
    update_time     timestamp  default CURRENT_TIMESTAMP not null comment '修改时间，默认为当前'
)
    charset = utf8mb4;

create index rule_type
    on t_agent_condition (rule_type, rule_lower_type);

create table if not exists t_agent_month_status
(
    id                   bigint                                   not null comment 'yyyyMM + userId作为主键',
    user_id              bigint                                   null comment '用户id',
    month                int(4)                                   null comment '月',
    common_condition     tinyint(2)     default 0                 null comment '普通条件',
    effective_user_count tinyint(2)     default 0                 null comment '有效拉新用户',
    rate                 decimal(10, 4) default 0.0000            null comment '返佣比例',
    base_salary          decimal(10, 2) default 0.00              null comment '基础工资',
    create_time          timestamp      default CURRENT_TIMESTAMP null comment '创建时间',
    update_time          timestamp      default CURRENT_TIMESTAMP null comment '更新时间',
    primary key (id)
)
    charset = utf8mb4;

create index user_id
    on t_agent_month_status (user_id, month);

create table if not exists t_article
(
    id               bigint(10) auto_increment comment '主键ID'
        primary key,
    lottery_type     tinyint(10) default 2                 null comment '1-香港，2-澳门，3-台湾',
    user_id          bigint(10)                            null comment '用户ID',
    article_type_id  bigint                                null comment '文章类型ID',
    original_id      bigint(10)                            null comment '原始文章ID',
    type             tinyint(2)                            null comment '文章类型(3-交流，4-资料)',
    process          tinyint(2)  default 1                 null comment '同步处理',
    title            varchar(200)                          null comment '标题',
    summary          varchar(2000)                         null,
    number           int(10)                               null comment '期数',
    year             int(10)                               null comment '年份',
    thumb_up_count   int(10)     default 0                 not null comment '点赞数',
    comment_count    int(10)     default 0                 not null comment '评论数',
    click_count      int(10)     default 0                 null comment '点击次数',
    base_click_count int(10)     default 0                 null comment '点击次数基数',
    pubdate          int(10)     default 0                 null,
    verify_id        bigint                                null comment '审核人ID',
    verify_status    tinyint(2)                            null comment '状态(0-审核中，1-审核通过，2-审核不通过)',
    reason           varchar(255)                          null comment '审核结果',
    commend          tinyint(2)  default 0                 not null comment '是否推荐（0:不推荐；1:推荐）',
    top              tinyint(2)  default 0                 not null comment '置顶（0-否，1-是）',
    high_quality     tinyint(2)  default 0                 not null comment '精华帖（0-否，1-是）',
    sort             int         default 10000             not null comment '排序，正向排序：先按照sort，再按照时间排序。',
    status           tinyint(2)  default 1                 null comment '状态',
    create_time      timestamp   default CURRENT_TIMESTAMP not null comment '创建时间',
    update_time      timestamp   default CURRENT_TIMESTAMP not null on update CURRENT_TIMESTAMP comment '修改时间',
    original_data    varchar(128)                          null comment '原始数据'
)
    charset = utf8mb4;

create index original_id
    on t_article (original_id);

create index status
    on t_article (status, user_id, type);

create index top
    on t_article (top);

create index user_id
    on t_article (type, status, verify_status, article_type_id, user_id, high_quality);

create table if not exists t_article_content
(
    id          bigint(10) auto_increment comment '主键ID'
        primary key,
    description longtext                            null comment '描述',
    create_time timestamp default CURRENT_TIMESTAMP not null comment '创建时间',
    update_time timestamp default CURRENT_TIMESTAMP not null on update CURRENT_TIMESTAMP comment '修改时间'
)
    charset = utf8mb4;

create table if not exists t_article_copy1
(
    id               bigint(10) auto_increment comment '主键ID'
        primary key,
    lottery_type     tinyint(10) default 2                 null comment '1-香港，2-澳门，3-台湾',
    user_id          bigint(10)                            null comment '用户ID',
    article_type_id  bigint                                null comment '文章类型ID',
    original_id      bigint(10)                            null comment '原始文章ID',
    type             tinyint(2)                            null comment '文章类型(3-交流，4-资料)',
    process          tinyint(2)  default 1                 null comment '同步处理',
    title            varchar(200)                          null comment '标题',
    summary          varchar(2000)                         null,
    number           int(10)                               null comment '期数',
    year             int(10)                               null comment '年份',
    thumb_up_count   int(10)     default 0                 not null comment '点赞数',
    comment_count    int(10)     default 0                 not null comment '评论数',
    click_count      int(10)     default 0                 null comment '点击次数',
    base_click_count int(10)     default 0                 null comment '点击次数基数',
    pubdate          int(10)     default 0                 null,
    verify_id        bigint                                null comment '审核人ID',
    verify_status    tinyint(2)                            null comment '状态(0-审核中，1-审核通过，2-审核不通过)',
    reason           varchar(255)                          null comment '审核结果',
    commend          tinyint(2)  default 0                 not null comment '是否推荐（0:不推荐；1:推荐）',
    top              tinyint(2)  default 0                 not null comment '置顶（0-否，1-是）',
    high_quality     tinyint(2)  default 0                 not null comment '精华帖（0-否，1-是）',
    sort             int         default 10000             not null comment '排序，正向排序：先按照sort，再按照时间排序。',
    status           tinyint(2)  default 1                 null comment '状态',
    create_time      timestamp   default CURRENT_TIMESTAMP not null comment '创建时间',
    update_time      timestamp   default CURRENT_TIMESTAMP not null on update CURRENT_TIMESTAMP comment '修改时间',
    original_data    varchar(128)                          null comment '原始数据'
)
    charset = utf8mb4;

create index original_id
    on t_article_copy1 (original_id);

create index status
    on t_article_copy1 (status, user_id, type);

create index top
    on t_article_copy1 (top);

create index user_id
    on t_article_copy1 (type, status, verify_status, article_type_id, user_id, high_quality);

create table if not exists t_article_submit_rule
(
    id          bigint auto_increment
        primary key,
    name        varchar(16)                          not null,
    type        tinyint(2)                           not null,
    min_count   int        default 1                 not null,
    max_count   int                                  not null,
    description varchar(256)                         null,
    status      tinyint(2) default 1                 null,
    remark      varchar(256)                         null,
    create_time datetime   default CURRENT_TIMESTAMP not null,
    update_time datetime                             null on update CURRENT_TIMESTAMP
)
    collate = utf8mb4_bin;

create table if not exists t_article_type
(
    id                 bigint(10) auto_increment comment '主键ID'
        primary key,
    lottery_type       tinyint(10) default 2                 null comment '1-香港，2-澳门，3-台湾',
    author_user_id     bigint(10)                            null comment '默认作者ID',
    original_id        bigint(10)                            null,
    name               varchar(200)                          null comment '名称',
    picture_url        varchar(255)                          null,
    letter             varchar(100)                          null comment '拼音',
    hot                tinyint(2)  default 0                 null comment '热帖',
    status             tinyint(2)  default 1                 null comment '状态',
    type               tinyint(2)  default 4                 null comment '文章类型(4-资料，2-高手)',
    display_article_id bigint(10)                            null comment '默认展示的文章ID',
    sort               int(10)     default 500               null comment '排序字段，越小排序越在前面',
    collection_count   int(10)     default 0                 null comment '收藏次数',
    remark             varchar(500)                          null comment '备注',
    create_time        timestamp   default CURRENT_TIMESTAMP not null comment '创建时间',
    update_time        timestamp   default CURRENT_TIMESTAMP not null comment '修改时间',
    uuid               varchar(50)                           null,
    keyword            varchar(50)                           null,
    publish_template   varchar(512)                          null comment '自动发帖模板',
    constraint uuid
        unique (uuid)
)
    charset = utf8mb4;

create table if not exists t_authority
(
    id          bigint auto_increment comment '主键ID'
        primary key,
    parent_id   bigint     default 0                 not null comment '父类的ID，最上级的默认为0',
    name        varchar(32)                          null comment '权限名称',
    url         varchar(64)                          null comment '权限的路径',
    remark      varchar(512)                         null comment '备注',
    status      tinyint(2) default 1                 not null comment '有效状态',
    create_time timestamp  default CURRENT_TIMESTAMP not null
)
    charset = utf8mb4;

create table if not exists t_bank
(
    id          bigint(11) auto_increment
        primary key,
    name        varchar(64)                         not null comment '银行名称',
    status      tinyint   default 1                 not null comment '1-启用 0-禁用',
    create_time timestamp default CURRENT_TIMESTAMP not null comment '创建时间',
    update_time datetime                            null on update CURRENT_TIMESTAMP comment '修改时间',
    constraint index_name
        unique (name)
)
    charset = utf8mb4;

create table if not exists t_base_user
(
    id                      bigint(10) auto_increment comment '主键ID'
        primary key,
    nickname                varchar(50)                              null comment '真实姓名',
    username                varchar(20)                              null comment '用户名',
    wechat_union_id         varchar(50)                              null comment '微信开放平台unionid',
    wechat_nickname         varchar(200)                             null comment '微信昵称',
    sex                     tinyint(2)     default 0                 null comment '性别(0:未知;1:男;2:女)',
    password                varchar(50)                              null comment '密码',
    mobile                  varchar(20)                              null comment '手机号码',
    status                  tinyint(2)     default 1                 null comment '状态',
    type                    tinyint(2)     default 2                 null comment '类型（1:后台管理员；2:app用户,3:虚拟用户）',
    process                 tinyint(2)     default 0                 null comment '是否压缩（1-是，0-否）',
    allowed_recharge_amount decimal(10, 2) default 0.00              null comment '允许充值的额度',
    allowed_change_bank     tinyint(2)     default 0                 null comment '是否允许修改银行卡，（1-是，0-否）',
    login_verify_code       varchar(256)                             null comment '验证码',
    last_login_time         datetime                                 null comment '上次登录时间',
    is_auto_comment         tinyint(2)     default 1                 null comment '是否参与自动评论',
    create_time             timestamp      default CURRENT_TIMESTAMP not null comment '创建时间',
    update_time             timestamp      default CURRENT_TIMESTAMP not null on update CURRENT_TIMESTAMP comment '修改时间',
    operator_id             bigint                                   null comment '最后一次操作人',
    constraint wechat_union_id
        unique (wechat_union_id)
)
    charset = utf8mb4;

create table if not exists t_black_list
(
    id             bigint(11) auto_increment
        primary key,
    user_id        bigint(11)   null comment '用户id',
    phone_number   varchar(20)  null comment '电话号码',
    device_id      varchar(200) null comment '设备号',
    create_time    timestamp    null comment '创建时间',
    remark         varchar(200) null comment '备注',
    opreation_name varchar(20)  null comment '操作人'
)
    charset = utf8mb4;

create table if not exists t_brokerage
(
    id             bigint auto_increment comment 'ID，自增长'
        primary key,
    user_id        bigint                                   not null comment '用户ID',
    relation_id    bigint                                   null,
    amount         decimal(18, 2)                           not null comment '金额',
    base_amount    decimal(18, 2) default 0.00              null comment '基数（日结用户为0）',
    brokerage_rate decimal(18, 2)                           null comment '佣金费率',
    order_no       varchar(32)                              null comment '交易的订单号',
    remark         varchar(128)                             null comment '备注',
    status         tinyint        default 1                 not null comment '状态 1为有效 0为无效 默认为1',
    create_time    timestamp      default CURRENT_TIMESTAMP not null comment '创建时间，默认为当前',
    update_time    timestamp      default CURRENT_TIMESTAMP not null on update CURRENT_TIMESTAMP comment '修改时间，默认为当前',
    constraint UK_ACCOUNT
        unique (order_no)
)
    comment '佣金' charset = utf8mb4;

create table if not exists t_brokerage_relation
(
    id               bigint auto_increment comment 'ID，自增长'
        primary key,
    user_id          bigint                              not null comment '用户ID',
    superior_user_id bigint                              not null comment '上级用户ID',
    level            tinyint(2)                          not null comment '用户ID',
    create_time      timestamp default CURRENT_TIMESTAMP not null comment '创建时间，默认为当前',
    update_time      timestamp default CURRENT_TIMESTAMP not null on update CURRENT_TIMESTAMP comment '修改时间，默认为当前',
    constraint uniqe_user_super_leve
        unique (user_id, superior_user_id)
)
    comment '佣金' charset = utf8mb4;

create table if not exists t_chat_bet_recommend
(
    id          bigint(16)                          not null,
    type_id     bigint(8)                           null,
    plan_number varchar(8)                          null comment '计划期数',
    user_id     bigint(16)                          null,
    year        int(8)                              null comment '年',
    term        int(8)                              null comment '期数',
    amount      decimal(16)                         null comment '金额',
    recommend   varchar(16)                         null comment '推荐',
    order_id    bigint(32)                          null,
    create_time timestamp default CURRENT_TIMESTAMP not null comment '创建时间',
    update_time timestamp default CURRENT_TIMESTAMP not null on update CURRENT_TIMESTAMP comment '更新时间',
    primary key (id),
    constraint `year+term+type`
        unique (year, term, type_id)
)
    collate = utf8mb4_bin;

create table if not exists t_chat_bet_recommend_type
(
    id          bigint(8) auto_increment
        primary key,
    name        varchar(32)                          null comment '类型名称',
    content     varchar(512)                         null comment '活动规则',
    status      tinyint(2) default 1                 not null comment '状态',
    sort        int(8)     default 1                 not null comment '排序',
    create_time timestamp  default CURRENT_TIMESTAMP not null comment '创建时间',
    update_time timestamp  default CURRENT_TIMESTAMP not null on update CURRENT_TIMESTAMP comment '更新时间'
)
    collate = utf8mb4_bin;

create table if not exists t_chat_record
(
    id             bigint auto_increment comment '主键ID'
        primary key,
    chat_room_id   bigint     default 0                 not null comment '聊天室ID(0-系统消息)',
    chat_room_type tinyint(2)                           null comment '聊天室类型',
    owner_user_id  bigint                               null comment '系统消息，消息所属人',
    user_id        bigint                               null comment '用户ID(通用公告为0)',
    nickname       varchar(255)                         null comment '用户名',
    to_user_id     bigint                               null comment '被@用户',
    to_nickname    varchar(255)                         null comment '被@用户昵称',
    content        varchar(1000)                        null comment '消息内容(文本、表情、图片地址、红包名称)',
    to_user_ids    varchar(255)                         null comment '被@用户',
    type           tinyint(2)                           null comment '类型(1-文本及表情，2-图片，3.发红包；4.抢红包，5-@,13-群组邀请)',
    status         tinyint(2) default 1                 not null comment '状态(0-无效，1-有效)',
    process_status tinyint(2) default 0                 null comment '0-待处理，1-接受，2-拒绝',
    create_time    timestamp  default CURRENT_TIMESTAMP not null comment '创建时间',
    update_time    timestamp  default CURRENT_TIMESTAMP not null comment '修改时间'
)
    charset = utf8mb4;

create index index1
    on t_chat_record (chat_room_id, owner_user_id);

create index index2
    on t_chat_record (chat_room_id, type);

create index index3
    on t_chat_record (user_id);

create index index4
    on t_chat_record (to_user_id);

create index index5
    on t_chat_record (type);

create index index6
    on t_chat_record (status);

create index index7
    on t_chat_record (create_time);

create table if not exists t_chat_red_packet
(
    id             bigint                                   not null comment '自增主键ID',
    message        varchar(255)                             null,
    chat_record_id bigint                                   null comment '聊天记录ID',
    user_id        bigint                                   null comment '用户ID',
    type           tinyint(2)     default 1                 null comment '类型',
    total_count    int(10)                                  null comment '红包个数',
    total_amount   decimal(10, 2)                           null comment '红包金额',
    opened_count   int(10)        default 0                 null comment '已拆个数',
    opened_amount  decimal(10, 2) default 0.00              null comment '已拆金额',
    status         tinyint(2)     default 1                 null comment '0-已结束，1-有效',
    end_time       timestamp                                null comment '结束时间',
    create_time    timestamp      default CURRENT_TIMESTAMP not null comment '创建时间',
    update_time    timestamp      default CURRENT_TIMESTAMP not null on update CURRENT_TIMESTAMP comment '修改时间',
    primary key (id)
)
    charset = utf8mb4;

create table if not exists t_chat_red_packet_record
(
    id             bigint                               not null comment 'user_id+read_packet_id',
    user_id        bigint                               not null comment '用户ID',
    amount         decimal(10, 2)                       null comment '红包金额',
    chat_record_id bigint                               null comment '聊天记录ID',
    red_packet_id  bigint                               not null comment '红包ID',
    type           tinyint(2) default 1                 null comment '类型',
    status         tinyint(2) default 1                 null,
    create_time    timestamp  default CURRENT_TIMESTAMP not null comment '创建时间',
    update_time    timestamp  default CURRENT_TIMESTAMP not null on update CURRENT_TIMESTAMP comment '修改时间',
    primary key (id),
    constraint chat_record_id
        unique (chat_record_id)
)
    charset = utf8mb4;

create table if not exists t_chat_room
(
    id          bigint auto_increment comment '主键ID'
        primary key,
    user_id     bigint     default 0                 not null comment '用户ID',
    name        varchar(128)                         null comment '聊天室名称',
    description varchar(500)                         null comment '聊天室简介',
    type        tinyint(2) default 2                 null comment '类型(1-聊天室，2-群组,3-系统)',
    status      tinyint(2) default 1                 not null comment '状态(0-无效，1-有效)',
    create_time timestamp  default CURRENT_TIMESTAMP not null comment '创建时间',
    update_time timestamp  default CURRENT_TIMESTAMP not null comment '修改时间'
)
    charset = utf8mb4;

create table if not exists t_chat_room_apply
(
    id          bigint auto_increment comment '主键ID（user_id）'
        primary key,
    user_id     bigint                               null comment '用户ID(通用公告为0)',
    description varchar(2000)                        null comment '理由',
    status      tinyint(2) default 1                 not null comment '状态(0-未读，1-审核通过，2-审核不通过)',
    type        tinyint(2) default 1                 not null comment '1-申请建群自个',
    reason      varchar(255)                         null comment '原因',
    create_time timestamp  default CURRENT_TIMESTAMP not null comment '创建时间',
    update_time timestamp  default CURRENT_TIMESTAMP not null comment '修改时间'
)
    charset = utf8mb4;

create index status
    on t_chat_room_apply (status, user_id);

create table if not exists t_chat_room_user
(
    id                  bigint                               not null comment 'room_id+user_id',
    chat_room_id        bigint                               not null comment '群主ID',
    chat_record_id      bigint                               null comment '邀请入群的chatRecordId',
    user_id             bigint                               null comment '用户ID',
    init_chat_record_id bigint                               null comment '进群时的该群最后一条聊天记录',
    type                tinyint(2) default 1                 null comment '类型(1-聊天室，2-群组)',
    status              tinyint(2) default 1                 not null comment '状态(0-无效，1-有效)',
    create_time         timestamp  default CURRENT_TIMESTAMP not null comment '创建时间',
    update_time         timestamp  default CURRENT_TIMESTAMP not null comment '修改时间',
    primary key (id),
    constraint chat_record_id
        unique (chat_record_id)
)
    charset = utf8mb4;

create index chat_room_id
    on t_chat_room_user (chat_room_id, status);

create table if not exists t_collection
(
    id          varchar(30)                          not null comment '主键ID',
    user_id     bigint(10)                           null comment '用户ID',
    related_id  bigint(10)                           null comment '图片明细ID',
    status      tinyint(2) default 1                 null comment '状态',
    type        tinyint(2)                           null comment '类型',
    remark      varchar(500)                         null comment '备注',
    create_time timestamp  default CURRENT_TIMESTAMP not null comment '创建时间',
    update_time timestamp  default CURRENT_TIMESTAMP not null on update CURRENT_TIMESTAMP comment '修改时间',
    tmp_id      bigint                               null,
    primary key (id),
    constraint user_id
        unique (user_id, related_id)
)
    charset = utf8mb4;

create table if not exists t_comment
(
    id             bigint(10) auto_increment comment '主键ID'
        primary key,
    `key`          bigint                               null comment 'userId+content哈希值',
    user_id        bigint(10)                           null comment '用户ID',
    to_user_id     bigint(10)                           null comment '回复对象用户ID',
    type           tinyint(2)                           null comment '类型（1-图片，2-发现,3-交流，4-资料，5-高手，6-评论）',
    related_id     bigint(10)                           null comment '关联ID',
    comment_id     bigint(10) default 0                 null comment '评论ID',
    level          int(4)                               null comment '层级(从1开始)',
    status         tinyint(2) default 1                 null comment '状态',
    content        varchar(500)                         null comment '内容',
    thumb_up_count int(10)    default 0                 null comment '点赞数',
    comment_count  int(10)    default 0                 null comment '评论数',
    create_time    timestamp  default CURRENT_TIMESTAMP not null comment '创建时间',
    update_time    timestamp  default CURRENT_TIMESTAMP not null comment '修改时间'
)
    charset = utf8mb4;

create index index1
    on t_comment (comment_id);

create index index2
    on t_comment (user_id, type, related_id);

create index index3
    on t_comment (user_id);

create index index4
    on t_comment (type, related_id, status);

create index index5
    on t_comment (status);

create index index6
    on t_comment (create_time);

create index index7
    on t_comment (level);

create index index8
    on t_comment (type);

create table if not exists t_comment_bak
(
    id             bigint(10) auto_increment comment '主键ID'
        primary key,
    `key`          bigint                               null comment 'userId+content哈希值',
    user_id        bigint(10)                           null comment '用户ID',
    to_user_id     bigint(10)                           null comment '回复对象用户ID',
    type           tinyint(2)                           null comment '类型（1-图片，2-发现,3-交流，4-资料，5-高手，6-评论）',
    related_id     bigint(10)                           null comment '关联ID',
    comment_id     bigint(10) default 0                 null comment '评论ID',
    level          int(4)                               null comment '层级(从1开始)',
    status         tinyint(2) default 1                 null comment '状态',
    content        varchar(500)                         null comment '内容',
    thumb_up_count int(10)    default 0                 null comment '点赞数',
    comment_count  int(10)    default 0                 null comment '评论数',
    create_time    timestamp  default CURRENT_TIMESTAMP not null comment '创建时间',
    update_time    timestamp  default CURRENT_TIMESTAMP not null comment '修改时间'
)
    charset = utf8mb4;

create index comment_id
    on t_comment_bak (comment_id);

create index `type-related_id-status`
    on t_comment_bak (type, related_id, status);

create index user_id
    on t_comment_bak (user_id);

create index `user_id-type-related_id`
    on t_comment_bak (user_id, type, related_id);

create table if not exists t_comment_bak_1
(
    id             bigint(10) auto_increment comment '主键ID'
        primary key,
    `key`          bigint                               null comment 'userId+content哈希值',
    user_id        bigint(10)                           null comment '用户ID',
    to_user_id     bigint(10)                           null comment '回复对象用户ID',
    type           tinyint(2)                           null comment '类型（1-图片，2-发现,3-交流，4-资料，5-高手，6-评论）',
    related_id     bigint(10)                           null comment '关联ID',
    comment_id     bigint(10) default 0                 null comment '评论ID',
    level          int(4)                               null comment '层级(从1开始)',
    status         tinyint(2) default 1                 null comment '状态',
    content        varchar(500)                         null comment '内容',
    thumb_up_count int(10)    default 0                 null comment '点赞数',
    comment_count  int(10)    default 0                 null comment '评论数',
    create_time    timestamp  default CURRENT_TIMESTAMP not null comment '创建时间',
    update_time    timestamp  default CURRENT_TIMESTAMP not null comment '修改时间'
)
    charset = utf8mb4;

create index comment_id
    on t_comment_bak_1 (comment_id);

create index `type-related_id-status`
    on t_comment_bak_1 (type, related_id, status);

create index user_id
    on t_comment_bak_1 (user_id);

create index `user_id-type-related_id`
    on t_comment_bak_1 (user_id, type, related_id);

create table if not exists t_comment_bak_2
(
    id             bigint(10) auto_increment comment '主键ID'
        primary key,
    `key`          bigint                               null comment 'userId+content哈希值',
    user_id        bigint(10)                           null comment '用户ID',
    to_user_id     bigint(10)                           null comment '回复对象用户ID',
    type           tinyint(2)                           null comment '类型（1-图片，2-发现,3-交流，4-资料，5-高手，6-评论）',
    related_id     bigint(10)                           null comment '关联ID',
    comment_id     bigint(10) default 0                 null comment '评论ID',
    level          int(4)                               null comment '层级(从1开始)',
    status         tinyint(2) default 1                 null comment '状态',
    content        varchar(500)                         null comment '内容',
    thumb_up_count int(10)    default 0                 null comment '点赞数',
    comment_count  int(10)    default 0                 null comment '评论数',
    create_time    timestamp  default CURRENT_TIMESTAMP not null comment '创建时间',
    update_time    timestamp  default CURRENT_TIMESTAMP not null comment '修改时间'
)
    charset = utf8mb4;

create index comment_id
    on t_comment_bak_2 (comment_id);

create index status
    on t_comment_bak_2 (status);

create index `type-related_id-status`
    on t_comment_bak_2 (type, related_id, status);

create index user_id
    on t_comment_bak_2 (user_id);

create index `user_id-type-related_id`
    on t_comment_bak_2 (user_id, type, related_id);

create table if not exists t_comment_repo
(
    id          bigint(10) auto_increment comment '主键ID'
        primary key,
    type        tinyint(2) default 0                 null comment '类型(0-通用，1-图片，2-发现，3-贴子中奖评论，4-贴子不中奖评论，5-活动宣传评论)',
    status      tinyint(2) default 1                 null comment '状态',
    content     varchar(2000)                        null comment '内容',
    create_time timestamp  default CURRENT_TIMESTAMP not null comment '创建时间',
    update_time timestamp  default CURRENT_TIMESTAMP not null comment '修改时间'
)
    charset = utf8mb4;

create table if not exists t_company_bank_account
(
    id                  bigint auto_increment
        primary key,
    bank_card_no        varchar(50)                              not null comment '账号',
    bank_id             bigint                                   not null comment '银行id',
    account_name        varchar(50)                              not null comment '户名',
    branch_bank_name    varchar(50)                              null comment '支行名字',
    amount_min          decimal(18, 2) default 10.00             not null comment '金额下限',
    amount_max          decimal(18, 2) default 999999999.00      not null comment '金额上限',
    sort                int            default 10                null comment '顺序',
    type                tinyint(2)     default 1                 not null comment '1-银行，2-二维码',
    status              tinyint(2)     default 1                 null comment '状态，1-可用，0-不可用',
    user_category_id    bigint         default 1                 not null comment '层级id',
    category_ids        varchar(256)                             null comment '层级id列表',
    total_income_amount decimal(10, 2) default 0.00              null comment '总收款金额',
    remark              varchar(50)                              null comment '备注',
    create_time         datetime       default CURRENT_TIMESTAMP not null comment '创建时间',
    update_time         datetime                                 null on update CURRENT_TIMESTAMP comment '修改时间'
)
    collate = utf8mb4_bin;

create table if not exists t_concern
(
    id              bigint                               not null comment '主键ID',
    user_id         bigint                               null comment '用户ID',
    concern_user_id bigint(10)                           null comment '被关注用户ID',
    type            tinyint(2)                           null comment '类型',
    status          tinyint(2) default 1                 not null comment '状态',
    create_time     timestamp  default CURRENT_TIMESTAMP not null comment '创建时间',
    update_time     timestamp  default CURRENT_TIMESTAMP not null comment '修改时间',
    primary key (id),
    constraint user_id_2
        unique (user_id, concern_user_id)
)
    charset = utf8mb4;

create index user_id
    on t_concern (user_id);

create table if not exists t_configuration_var
(
    id          bigint auto_increment comment '主键ID'
        primary key,
    code        varchar(64)                         null comment '常量CODE',
    value       text                                null comment '常量值',
    name        varchar(64)                         null comment '常量名称',
    status      tinyint   default 1                 not null comment '有效状态',
    create_time timestamp default CURRENT_TIMESTAMP not null comment '创建时间',
    update_time timestamp default CURRENT_TIMESTAMP not null on update CURRENT_TIMESTAMP comment '更新时间'
)
    charset = utf8mb4;

create table if not exists t_day_account
(
    id                             bigint                                   not null,
    stat_date                      date                                     null comment '日期',
    invite_num                     int            default 0                 null comment '邀请人数',
    withdraw_amount                decimal(18, 2) default 0.00              null comment '已提现金额',
    redpacket_amount               decimal(18, 2) default 0.00              null comment '拆红包金额',
    share_reward_amount            decimal(18, 2) default 0.00              null comment '分享奖励金额',
    register_reward_amount         decimal(18, 2)                           null comment '注册奖励金额',
    invite_reward_amount           decimal(18, 2)                           null comment '邀请奖励金额',
    received_invite_reward_amount  decimal(18, 2)                           null comment '已领取邀请金额',
    expire_invite_reward_amount    decimal(18, 2)                           null comment '邀请奖励已失效金额',
    fill_invite_code_reward_amount decimal(18, 2)                           null comment '填写邀请码奖励总金额',
    create_time                    timestamp      default CURRENT_TIMESTAMP null comment '创建时间',
    update_time                    timestamp      default CURRENT_TIMESTAMP null comment '修改时间',
    primary key (id),
    constraint stat_date
        unique (stat_date)
)
    charset = utf8mb4;

create table if not exists t_day_user
(
    id                         bigint                              not null comment 'yyyyMMdd作为ID',
    stat_date                  date                                null comment '日期',
    new_user_count             int(10)                             null comment '新增用户数',
    total_user_count           int(10)                             null comment '总用户数',
    new_register_user_count    int(10)                             null comment '新增注册用户数',
    total_register_user_count  int(10)                             null comment '总注册用户数',
    active_user_count          int(10)                             null comment '活跃用户数',
    start_up_count             int(10)                             null comment '启动次数',
    active_register_user_count int(10)                             null comment '活跃注册用户数',
    create_time                timestamp default CURRENT_TIMESTAMP null comment '创建时间',
    update_time                timestamp default CURRENT_TIMESTAMP null comment '修改时间',
    primary key (id),
    constraint stat_date
        unique (stat_date)
)
    charset = utf8mb4;

create table if not exists t_event
(
    id          bigint auto_increment comment '主键ID'
        primary key,
    profile_id  bigint                              null,
    day         int(10)                             null,
    model       varchar(50)                         null,
    event       varchar(20)                         null,
    user_id     bigint(10)                          null comment '用户ID',
    device_id   varchar(128)                        null comment '手机的唯一设备ID',
    push_id     varchar(100)                        null comment '安卓推送标识',
    os_type     tinyint(2)                          null comment '设备类型(1-安卓，2-ios）',
    `interval`  int(10)                             null comment '请求时长（毫秒）',
    create_time timestamp default CURRENT_TIMESTAMP not null comment '创建时间',
    update_time timestamp default CURRENT_TIMESTAMP not null on update CURRENT_TIMESTAMP comment '修改时间'
)
    charset = utf8mb4;

create index day
    on t_event (day, event, user_id, push_id);

create table if not exists t_event_bak_1
(
    id          bigint auto_increment comment '主键ID'
        primary key,
    profile_id  bigint                              null,
    day         int(10)                             null,
    model       varchar(50)                         null,
    event       varchar(20)                         null,
    user_id     bigint(10)                          null comment '用户ID',
    device_id   varchar(128)                        null comment '手机的唯一设备ID',
    push_id     varchar(100)                        null comment '安卓推送标识',
    os_type     tinyint(2)                          null comment '设备类型(1-安卓，2-ios）',
    `interval`  int(10)                             null comment '请求时长（毫秒）',
    create_time timestamp default CURRENT_TIMESTAMP not null comment '创建时间',
    update_time timestamp default CURRENT_TIMESTAMP not null on update CURRENT_TIMESTAMP comment '修改时间'
)
    charset = utf8mb4;

create index day
    on t_event_bak_1 (day, event, user_id, push_id);

create table if not exists t_exchange_platform
(
    id          bigint auto_increment comment '主键ID'
        primary key,
    name        varchar(32)                         null comment '名称',
    url         varchar(128)                        null comment '平台的注册地址',
    status      tinyint   default 1                 not null comment '状态：0-无效；1-有效',
    create_time timestamp default CURRENT_TIMESTAMP not null comment '创建时间',
    update_time timestamp default CURRENT_TIMESTAMP not null on update CURRENT_TIMESTAMP comment '更新时间'
)
    comment '兑换平台表' charset = utf8mb4;

create table if not exists t_feedback
(
    id          bigint(10) auto_increment comment '主键ID'
        primary key,
    user_id     bigint(10)                           null comment '用户ID',
    description varchar(2000)                        null comment '描述',
    title       varchar(200)                         null comment '标题',
    status      tinyint(2) default 1                 null comment '状态',
    create_time timestamp  default CURRENT_TIMESTAMP not null comment '创建时间',
    update_time timestamp  default CURRENT_TIMESTAMP not null on update CURRENT_TIMESTAMP comment '修改时间'
)
    charset = utf8mb4;

create table if not exists t_feedback_picture
(
    id          bigint auto_increment comment '主键ID'
        primary key,
    feedback_id bigint                              null comment '发现的关联ID',
    file_path   varchar(256)                        null comment '图片的地址',
    height      int                                 null comment '图片的高度',
    width       int                                 null comment '图片的宽度',
    sort        int       default 1                 null comment '排序的字段，从1开始，1排在前面',
    create_time timestamp default CURRENT_TIMESTAMP null comment '创建时间'
)
    charset = utf8mb4;

create index show_id
    on t_feedback_picture (feedback_id);

create table if not exists t_fig_type
(
    id              bigint auto_increment
        primary key,
    fig_uuid        varchar(50)  null,
    picture_type_id bigint       null,
    color           tinyint(2)   null,
    keyword         varchar(255) null,
    year            int(10)      null
)
    charset = utf8mb4;

create table if not exists t_game
(
    id            bigint auto_increment
        primary key,
    code          varchar(20)                          null,
    type          tinyint(2)                           null comment '1-彩票类，2-游戏类',
    name          varchar(20)                          not null,
    display       tinyint(2) default 0                 not null comment '1-横屏，0-竖屏',
    sort          int        default 100               null,
    status        tinyint(2) default 1                 not null comment '状态，0-无效，1-有效，2-维护',
    is_first      tinyint(2)                           not null,
    has_child     tinyint(2) default 0                 null comment '是否含有子菜单，1-是，0-否',
    platform_code tinyint(2) default 1                 null comment '平台code',
    create_time   datetime   default CURRENT_TIMESTAMP not null,
    update_time   datetime                             null on update CURRENT_TIMESTAMP,
    constraint index3
        unique (platform_code, code)
)
    collate = utf8mb4_bin;

create index index1
    on t_game (platform_code);

create index index2
    on t_game (code);

create table if not exists t_guess
(
    id               bigint(10)                            not null comment '主键ID(year+number)',
    lottery_type     tinyint(10) default 2                 null comment '1-香港，2-澳门，3-台湾',
    year             int(10)                               null comment '年份',
    number           int(10)                               null comment '期数',
    picture_content  longtext                              null comment '图片说明',
    picture_title    varchar(64)                           null comment '图片标题',
    video_content    longtext                              null comment '视频说明',
    video_title      varchar(64)                           null comment '视频标题',
    video_url        varchar(500)                          null comment '视频URL',
    thumb_up_count   int(10)     default 0                 not null comment '点赞数',
    comment_count    int(10)     default 0                 not null comment '评论数',
    click_count      int(10)     default 0                 null comment '点击次数',
    base_click_count int(10)     default 0                 null comment '点击次数基数',
    collect_count    int(10)     default 0                 null comment '收藏数',
    picture_count    int(10)                               null comment '图片数量',
    status           tinyint(2)  default 1                 null comment '状态',
    create_time      timestamp   default CURRENT_TIMESTAMP not null comment '创建时间',
    update_time      timestamp   default CURRENT_TIMESTAMP not null on update CURRENT_TIMESTAMP comment '修改时间',
    primary key (id)
)
    charset = utf8mb4;

create table if not exists t_guess_copy1
(
    id               bigint(10)                            not null comment '主键ID(year+number)',
    lottery_type     tinyint(10) default 2                 null comment '1-香港，2-澳门，3-台湾',
    year             int(10)                               null comment '年份',
    number           int(10)                               null comment '期数',
    picture_content  longtext                              null comment '图片说明',
    picture_title    varchar(64)                           null comment '图片标题',
    video_content    longtext                              null comment '视频说明',
    video_title      varchar(64)                           null comment '视频标题',
    video_url        varchar(500)                          null comment '视频URL',
    thumb_up_count   int(10)     default 0                 not null comment '点赞数',
    comment_count    int(10)     default 0                 not null comment '评论数',
    click_count      int(10)     default 0                 null comment '点击次数',
    base_click_count int(10)     default 0                 null comment '点击次数基数',
    collect_count    int(10)     default 0                 null comment '收藏数',
    picture_count    int(10)                               null comment '图片数量',
    status           tinyint(2)  default 1                 null comment '状态',
    create_time      timestamp   default CURRENT_TIMESTAMP not null comment '创建时间',
    update_time      timestamp   default CURRENT_TIMESTAMP not null on update CURRENT_TIMESTAMP comment '修改时间',
    primary key (id)
)
    charset = utf8mb4;

create table if not exists t_help_record
(
    id             bigint                                  not null comment '格式yyMMdduser_idhelp_user_id',
    help_id        varchar(128)                            not null comment '被助力活动id',
    helped_user_id bigint                                  not null comment '被助力用户id',
    help_user_id   bigint                                  not null comment '助力用户id',
    money          decimal(6, 2) default 0.01              not null comment '助力金额',
    acquired_money decimal(6, 2)                           not null comment '助力回赠金额',
    remark         varchar(128)                            null comment '备注',
    create_time    datetime      default CURRENT_TIMESTAMP not null comment '创建时间',
    update_time    datetime                                null on update CURRENT_TIMESTAMP comment '修改时间',
    primary key (id)
)
    charset = utf8mb4;

create index index1
    on t_help_record (helped_user_id, help_user_id, create_time);

create index index2
    on t_help_record (help_user_id, acquired_money);

create table if not exists t_help_start
(
    id             bigint                                  not null comment '格式，yyyyMMdduserId',
    activity_id    bigint                                  not null comment '活动id',
    user_id        bigint                                  not null comment '用户id',
    total_money    decimal(5, 2)                           null comment '助力预期获得总金额',
    acquired_money decimal(5, 2) default 0.00              not null comment '已获得金额',
    helped_count   int           default 0                 not null comment '被助力次数',
    status         tinyint(2)    default 0                 null comment '领取状态，0-未领取，1-已领取,-1无效',
    create_time    datetime      default CURRENT_TIMESTAMP not null comment '创建时间',
    update_time    datetime                                null on update CURRENT_TIMESTAMP comment '修改时间',
    primary key (id)
)
    charset = utf8mb4;

create index index2
    on t_help_start (user_id, create_time, status);

create table if not exists t_host
(
    id          bigint auto_increment comment 'ID，自增长'
        primary key,
    url         varchar(255)                         not null,
    remark      varchar(500)                         null,
    type        tinyint(2) default 0                 null comment '0-默认域名，1-接口域名，2-文件域名，3-推广域名，4-后台域名',
    sort        int(4)     default 1                 null comment '排序',
    status      tinyint(2) default 1                 not null comment '状态 1为有效 0为无效 默认为1',
    create_time timestamp  default CURRENT_TIMESTAMP not null comment '创建时间，默认为当前',
    update_time timestamp  default CURRENT_TIMESTAMP not null on update CURRENT_TIMESTAMP comment '修改时间，默认为当前'
)
    comment '佣金' charset = utf8mb4;

create table if not exists t_host_allow
(
    id          varchar(32)                          not null,
    user_id     bigint                               null,
    status      tinyint(2) default 1                 not null,
    remark      varchar(128)                         null,
    create_time datetime   default CURRENT_TIMESTAMP null,
    update_time datetime                             null on update CURRENT_TIMESTAMP,
    primary key (id)
)
    collate = utf8mb4_bin;

create table if not exists t_id_generator
(
    id          bigint auto_increment comment '主键ID'
        primary key,
    update_time timestamp default CURRENT_TIMESTAMP null
)
    charset = utf8mb4;

create table if not exists t_info
(
    id               bigint auto_increment
        primary key,
    type             tinyint(2)                           not null comment '类型，1-美女，2-博事件，3-段子，4-图片',
    title            varchar(1024)                        not null comment '标题',
    info_key         bigint     default 0                 null,
    click_count      int        default 0                 null comment '浏览量',
    thumb_up_count   int        default 0                 null comment '点赞数',
    thumb_down_count int        default 0                 null comment '点踩量',
    collection_count int        default 0                 null comment '收藏量',
    sort             int        default 10000             null comment '排序，默认10000',
    status           tinyint(2) default 1                 null comment '状态',
    create_time      datetime   default CURRENT_TIMESTAMP null,
    update_time      datetime                             null on update CURRENT_TIMESTAMP
)
    collate = utf8mb4_bin;

create index index1
    on t_info (type, status, sort, info_key);

create index index2
    on t_info (type);

create index index3
    on t_info (create_time);

create table if not exists t_info_content
(
    id          bigint                             not null,
    content     longtext                           null comment '正文',
    create_time datetime default CURRENT_TIMESTAMP null,
    update_time datetime                           null on update CURRENT_TIMESTAMP,
    primary key (id)
)
    collate = utf8mb4_bin;

create table if not exists t_info_girl_type
(
    id          bigint auto_increment
        primary key,
    code        int                                  not null,
    name        varchar(20)                          not null,
    url         varchar(128)                         not null,
    pages       int        default 0                 not null,
    page_num    int        default 0                 null,
    status      tinyint(2) default 1                 null,
    sort        int        default 10000             null,
    create_time datetime   default CURRENT_TIMESTAMP null,
    update_time datetime                             null on update CURRENT_TIMESTAMP
)
    collate = utf8mb4_bin;

create table if not exists t_invite
(
    id          bigint auto_increment comment 'ID，自增长'
        primary key,
    user_id     bigint                               not null comment '用户ID',
    code        varchar(128)                         null comment '邀请码',
    qrcode_path varchar(600)                         null comment '二维码地址',
    status      tinyint(2) default 1                 not null comment '状态 1为有效 0为无效 默认为1',
    create_time timestamp  default CURRENT_TIMESTAMP not null comment '创建时间，默认为当前',
    update_time timestamp  default CURRENT_TIMESTAMP not null on update CURRENT_TIMESTAMP comment '修改时间，默认为当前',
    constraint code
        unique (code)
)
    comment '佣金' charset = utf8mb4;

create table if not exists t_invite_record
(
    id              bigint                               not null comment 'invitedUserId作为主键ID',
    invite_user_id  bigint                               not null comment '用户ID',
    invited_user_id bigint                               null,
    type            tinyint(2) default 2                 null comment '类型(备用)',
    status          tinyint(2) default 0                 not null comment '该奖励是否被领取',
    create_time     timestamp  default CURRENT_TIMESTAMP not null comment '创建时间，默认为当前',
    update_time     timestamp  default CURRENT_TIMESTAMP not null on update CURRENT_TIMESTAMP comment '修改时间，默认为当前',
    primary key (id),
    constraint invited_user_id
        unique (invited_user_id)
)
    comment '佣金' charset = utf8mb4;

create index invite_user_id
    on t_invite_record (invite_user_id);

create table if not exists t_invite_reward
(
    id               bigint                               not null comment 'level+ from_user_id',
    type             tinyint(2) default 1                 null comment '类型',
    amount           decimal(10, 2)                       null comment '红包金额',
    status           tinyint(2) default 1                 null comment '-1不可领取，0-待领取，1-已领取，2-失效',
    user_id          bigint                               null comment '领取奖励用户Id',
    from_user_id     bigint                               not null comment '来源用户Id',
    invite_record_id bigint                               not null comment 'invite_record_id',
    level            int(4)                               not null comment '级别(1或者2)',
    create_time      timestamp  default CURRENT_TIMESTAMP not null comment '创建时间',
    update_time      timestamp  default CURRENT_TIMESTAMP not null on update CURRENT_TIMESTAMP comment '修改时间',
    primary key (id)
)
    charset = utf8mb4;

create index invite_record_id
    on t_invite_reward (invite_record_id, status, user_id, update_time);

create table if not exists t_invite_stat
(
    id                           bigint                               not null comment 'user_id作为主键',
    user_id                      bigint                               null comment '用户ID',
    today_invite_count           int(10)    default 0                 null comment '今日邀请数',
    today_effective_invite_count int(10)    default 0                 null comment '今日有效邀请数',
    month_invite_count           int(10)    default 0                 null comment '本月邀请数',
    month_effective_invite_count int(10)    default 0                 null comment '本月有效邀请数',
    total_invite_count           int(10)    default 0                 null comment '总邀请数',
    total_effective_invite_count int(10)    default 0                 null comment '总有效邀请数',
    type                         tinyint(2) default 2                 null comment '类型(备用)',
    status                       tinyint(2) default 0                 not null comment '该奖励是否被领取',
    create_time                  timestamp  default CURRENT_TIMESTAMP not null comment '创建时间，默认为当前',
    update_time                  timestamp  default CURRENT_TIMESTAMP not null on update CURRENT_TIMESTAMP comment '修改时间，默认为当前',
    primary key (id)
)
    comment '佣金' charset = utf8mb4;

create table if not exists t_invite_stat_day
(
    id           bigint                             not null,
    user_id      bigint                             not null comment '用户id',
    invite_count int      default 0                 null comment '邀请好友数',
    stat_date    int                                not null comment 'yyyyMMdd',
    create_time  datetime default CURRENT_TIMESTAMP not null,
    update_time  datetime                           null on update CURRENT_TIMESTAMP,
    primary key (id)
)
    collate = utf8mb4_bin;

create index stat_date
    on t_invite_stat_day (stat_date);

create table if not exists t_job_record
(
    id          bigint auto_increment comment 'ID，自增长'
        primary key,
    related_id  bigint                              null,
    type        tinyint(2)                          null comment '1-兑换',
    retry_count int(10)                             null comment '重试次数',
    result      varchar(1000)                       null,
    status      tinyint(2)                          null comment '0-失败，1-成功',
    create_time timestamp default CURRENT_TIMESTAMP not null comment '创建时间，默认为当前',
    update_time timestamp default CURRENT_TIMESTAMP not null comment '修改时间，默认为当前'
)
    comment '提现' charset = utf8mb4;

create table if not exists t_keyword
(
    id          bigint(10) auto_increment comment '主键ID'
        primary key,
    type        tinyint(2) default 0                 null comment '类型(0-通用，1-评论，2-用户名)',
    title       varchar(200)                         null comment '标题',
    status      tinyint(2) default 1                 null comment '状态',
    content     varchar(2000)                        null comment '内容',
    create_time timestamp  default CURRENT_TIMESTAMP not null comment '创建时间',
    update_time timestamp  default CURRENT_TIMESTAMP not null comment '修改时间'
)
    charset = utf8mb4;

create table if not exists t_keyword_replace
(
    id          bigint(10) auto_increment comment '主键ID'
        primary key,
    type        tinyint(2) default 0                 null comment '类型(0-通用，1-评论，2-用户名)',
    source      varchar(200)                         null comment '被替换字符',
    target      varchar(200)                         null comment '替换后字符',
    status      tinyint(2) default 1                 null comment '状态',
    create_time timestamp  default CURRENT_TIMESTAMP not null comment '创建时间',
    update_time timestamp  default CURRENT_TIMESTAMP not null comment '修改时间'
)
    charset = utf8mb4;

create table if not exists t_login_info
(
    id          bigint(10) auto_increment comment '主键ID'
        primary key,
    user_id     bigint(10)                           null comment '用户ID',
    client_type tinyint(2)                           null comment '客户端类型',
    ip          varchar(32)                          null comment '登录ip',
    device_id   varchar(128)                         null comment '设备ID',
    token       varchar(100)                         null comment 'token',
    status      tinyint(2) default 1                 null comment '状态',
    end_time    timestamp  default CURRENT_TIMESTAMP not null comment '过期时间',
    create_time timestamp  default CURRENT_TIMESTAMP not null comment '创建时间',
    update_time timestamp  default CURRENT_TIMESTAMP not null on update CURRENT_TIMESTAMP comment '修改时间',
    constraint user_id_client_type
        unique (user_id, client_type)
)
    charset = utf8mb4;

create index client_type
    on t_login_info (client_type);

create index user_id
    on t_login_info (user_id);

create table if not exists t_login_record
(
    id          bigint(10) auto_increment comment '主键ID'
        primary key,
    user_id     bigint(10)                          null comment '用户ID',
    client_type tinyint(2)                          null comment '客户端类型',
    device_id   varchar(50)                         null comment '设备id',
    ip          varchar(100)                        null comment '启动APP时的IP地址',
    same_ip     tinyint(1)                          null,
    create_time timestamp default CURRENT_TIMESTAMP not null comment '创建时间',
    update_time timestamp default CURRENT_TIMESTAMP not null on update CURRENT_TIMESTAMP comment '修改时间'
)
    charset = utf8mb4;

create table if not exists t_lottery_plan
(
    id               bigint(11) unsigned auto_increment
        primary key,
    lottery_type     tinyint(2) default 2                 null comment '1-香港，2-澳门，3-台湾',
    original_id      bigint(11)                           null comment '原始ID',
    year             int(11) unsigned                     not null,
    period int (11) unsigned not null,
    lottery_time     timestamp                            null comment '开奖时间',
    create_time      timestamp  default CURRENT_TIMESTAMP null,
    update_time      timestamp  default CURRENT_TIMESTAMP not null on update CURRENT_TIMESTAMP,
    silk_bag_content varchar(255)                         null comment '玄机锦囊内容',
    original_data    varchar(200)                         null comment '录入原始记录',
    constraint year
        unique (year, period, lottery_type)
)
    charset = utf8;

create table if not exists t_lottery_recommend
(
    id           bigint(11) unsigned auto_increment
        primary key,
    lottery_type tinyint(10)  default 2                 null comment '1-香港，2-澳门，3-台湾',
    original_id  bigint(11)                             null comment '原始ID',
    year         int(4) unsigned                        not null,
    period int (3) unsigned not null,
    animals      varchar(200) default ''                not null,
    numbers      varchar(200)                           null,
    create_time  timestamp    default CURRENT_TIMESTAMP null,
    update_time  timestamp    default CURRENT_TIMESTAMP null,
    constraint year
        unique (year, period, lottery_type)
)
    charset = utf8;

create table if not exists t_lottery_record
(
    id                          bigint(11) unsigned auto_increment
        primary key,
    lottery_type                tinyint(2)    default 2                 null comment '1-香港，2-澳门，3-台湾',
    original_id                 bigint(11)                              null comment '原始ID',
    year                        int(11) unsigned                        not null,
    period int (11) unsigned not null,
    first_sx                    varchar(100)  default '猪'              not null comment '第一个生肖',
    dateline                    int(10)       default 0                 not null,
    date                        varchar(100)  default ''                not null,
    lottery_time                timestamp                               null comment '开奖时间',
    sx                          varchar(1000) default ''                not null comment '生肖',
    wx                          varchar(500)                            null comment '五行',
    numbers                     varchar(5000) default ''                not null comment '数字',
    create_time                 timestamp     default CURRENT_TIMESTAMP not null,
    update_time                 timestamp     default CURRENT_TIMESTAMP not null on update CURRENT_TIMESTAMP,
    original_data               varchar(200)                            null comment '录入原始记录',
    status                      tinyint(2)    default 0                 null comment '状态(0-最新记录，1-历史记录)',
    lottery_video_path          varchar(512)                            null comment '开奖视频回放地址',
    lottery_video_status        tinyint(2)    default 0                 null comment '开奖回放视频上传状态，0-未上传，1-已上传',
    market_article_count_status tinyint(2)    default 0                 null comment '淘料市场开奖结算状态，1-已结算，0-未结算',
    complete_status             tinyint(2)    default 0                 null comment '完成状态，1-已完成，0-未完成',
    constraint year
        unique (year, period, lottery_type)
)
    charset = utf8;

create index index1
    on t_lottery_record (lottery_video_status);

create index index2
    on t_lottery_record (market_article_count_status);

create index index3
    on t_lottery_record (complete_status);

create index status
    on t_lottery_record (status);

create table if not exists t_lottery_record_detail
(
    id           bigint(11) unsigned auto_increment
        primary key,
    lottery_type tinyint(2)  default 2                 null comment '1-香港，2-澳门，3-台湾',
    record_id    bigint(11)                            not null comment '开奖记录ID',
    year         int(4) unsigned                       not null,
    period int (3) unsigned not null,
    value        varchar(20) default ''                not null comment '数字',
    hot          tinyint(2)                            not null,
    special      tinyint(2)                            not null comment '0-正码，1-特码',
    type         tinyint(2)                            not null comment '1-数字，2-生肖，3-颜色，4-尾数',
    create_time  timestamp   default CURRENT_TIMESTAMP null,
    update_time  timestamp   default CURRENT_TIMESTAMP null
)
    charset = utf8;

create index record_id
    on t_lottery_record_detail (record_id);

create index year
    on t_lottery_record_detail (year, period, hot, special, type, lottery_type);

create table if not exists t_lottery_relation
(
    id     bigint(10) auto_increment
        primary key,
    number varchar(10) null comment '数字',
    color  tinyint(2)  null comment '颜色(1红色，2-蓝色，3-绿色)',
    wx     varchar(10) null comment '五行(金木水火土)',
    sx     varchar(10) null comment '生肖(鼠牛虎兔...)',
    year   int(4)      null comment '年份',
    constraint number
        unique (number, year)
)
    charset = utf8mb4;

create table if not exists t_lottery_relation_copy1
(
    id     bigint(10) auto_increment
        primary key,
    number varchar(10) null comment '数字',
    color  tinyint(2)  null comment '颜色(1红色，2-蓝色，3-绿色)',
    wx     varchar(10) null comment '五行(金木水火土)',
    sx     varchar(10) null comment '生肖(鼠牛虎兔...)',
    year   int(4)      null comment '年份',
    constraint number
        unique (number, year)
)
    charset = utf8mb4;

create table if not exists t_market_article
(
    id                                bigint auto_increment
        primary key,
    lottery_type                      tinyint(2)                               not null comment '彩种，1-香港，2-澳门，3-台湾',
    user_id                           bigint                                   not null comment '用户ID',
    title                             varchar(64)                              not null comment '标题',
    type                              tinyint(2)                               not null comment '类型',
    number_type                       int                                      null comment '号码类型',
    number_type_name                  varchar(16)                              null comment '号码类型',
    content                           varchar(1024)                            not null comment '内容',
    year                              int                                      null comment '年份',
    number                            int                                      null comment '期数',
    full_number                       int                                      null comment '全期数',
    lottery_plan_id                   bigint         default 0                 not null comment '开奖计划ID',
    click_count                       int            default 0                 null comment '点击数',
    charge                            tinyint(2)     default 0                 not null comment '是否收费，1-是，0-否',
    amount                            decimal(10, 2) default 0.00              null comment '积分',
    verify_status                     tinyint(2)     default 0                 null comment '审核状态',
    verify_result                     varchar(256)                             null comment '审核原因',
    status                            tinyint(2)     default 1                 null comment '状态',
    result                            tinyint(2)     default 0                 not null comment '结果，0-未开奖，1-胜，2-负',
    user_professional_article_stat_id bigint                                   not null comment '用户ID',
    remark                            varchar(256)                             null comment '备注',
    create_time                       datetime       default CURRENT_TIMESTAMP not null comment '创建时间',
    update_time                       datetime                                 null on update CURRENT_TIMESTAMP comment '修改时间',
    constraint index1
        unique (lottery_type, user_id, type, year, number)
)
    collate = utf8mb4_bin;

create index index10
    on t_market_article (create_time);

create index index11
    on t_market_article (charge);

create index index2
    on t_market_article (lottery_type);

create index index3
    on t_market_article (user_id);

create index index4
    on t_market_article (type);

create index index5
    on t_market_article (status);

create index index6
    on t_market_article (result);

create index index7
    on t_market_article (full_number);

create index index8
    on t_market_article (user_professional_article_stat_id);

create index index9
    on t_market_article (verify_status);

create table if not exists t_market_article_account_record
(
    id                bigint auto_increment comment '主键ID'
        primary key,
    lottery_type      tinyint(2)                               null comment '1-香港，2-澳门，3-台湾',
    user_id           bigint                                   not null comment '用户ID',
    related_id        bigint                                   null comment '关联ID',
    order_no          varchar(50)                              not null comment '订单号',
    payment_type      tinyint(2)                               not null comment '收支类型(-1：支出，1：收入，0：非收支记录)',
    amount            decimal(18, 2) default 0.00              not null comment '金额',
    available_balance decimal(18, 2) default 0.00              null comment '当前余额',
    trade_type        tinyint(2)                               not null,
    status            tinyint(2)     default 1                 not null comment '状态(1-到账，2-冻结,3-取消)',
    remark            varchar(256)                             null comment '备注',
    create_time       datetime       default CURRENT_TIMESTAMP not null comment '创建时间',
    update_time       datetime                                 null on update CURRENT_TIMESTAMP comment '修改时间'
)
    charset = utf8mb4;

create index index1
    on t_market_article_account_record (user_id);

create index index2
    on t_market_article_account_record (create_time);

create index index3
    on t_market_article_account_record (trade_type);

create index order_no
    on t_market_article_account_record (order_no);

create table if not exists t_market_article_purchase_record
(
    id          bigint                                   not null,
    user_id     bigint                                   not null,
    related_id  bigint                                   not null,
    order_no    varchar(64)                              not null,
    amount      decimal(10, 2) default 0.00              not null,
    guaranteed  tinyint(2)     default 0                 null,
    remark      varchar(256)                             null,
    status      tinyint(2)     default 1                 null,
    create_time datetime       default CURRENT_TIMESTAMP not null,
    update_time datetime                                 null on update CURRENT_TIMESTAMP,
    primary key (id),
    constraint index3
        unique (order_no)
)
    collate = utf8mb4_bin;

create index index1
    on t_market_article_purchase_record (user_id);

create index index2
    on t_market_article_purchase_record (related_id);

create table if not exists t_market_article_report
(
    id               bigint auto_increment
        primary key,
    user_id          bigint                               not null comment '举报用户ID',
    reported_user_id bigint                               not null comment '被举报用户ID',
    related_id       bigint                               not null comment '推荐资料ID',
    type             tinyint(2)                           not null comment '1-发布广告，2-垃圾信息，3-欺诈骗钱，4-其他',
    description      varchar(300)                         not null comment '举报内容',
    status           tinyint(2) default 0                 not null comment '状态',
    remark           varchar(64)                          null comment '备注',
    result           varchar(256)                         null comment '处理结果',
    create_time      datetime   default CURRENT_TIMESTAMP not null comment '创建时间',
    update_time      datetime                             null on update CURRENT_TIMESTAMP
)
    collate = utf8mb4_bin;

create index index1
    on t_market_article_report (reported_user_id);

create index index2
    on t_market_article_report (user_id);

create index index3
    on t_market_article_report (type);

create index index4
    on t_market_article_report (status);

create table if not exists t_market_article_reward_record
(
    id               bigint auto_increment
        primary key,
    user_id          bigint                               not null,
    rewarded_user_id bigint                               not null,
    amount           decimal(10, 2)                       not null,
    order_no         varchar(64)                          not null,
    status           tinyint(2) default 1                 null,
    remark           varchar(256)                         null,
    create_time      datetime   default CURRENT_TIMESTAMP not null,
    update_time      datetime                             null on update CURRENT_TIMESTAMP
)
    collate = utf8mb4_bin;

create index index1
    on t_market_article_reward_record (user_id);

create index index2
    on t_market_article_reward_record (rewarded_user_id);

create index index3
    on t_market_article_reward_record (order_no);

create table if not exists t_menu
(
    id          bigint auto_increment comment '主键ID'
        primary key,
    parent_id   bigint    default 0                 not null comment '父级菜单的ID，默认为0.',
    parent_name varchar(32)                         null comment '父级名称',
    name        varchar(32)                         null comment '名称',
    `key`       varchar(64)                         null comment '该菜单的关键字',
    url         varchar(256)                        null comment 'url',
    sort        int                                 null comment '排序',
    status      tinyint   default 1                 not null comment '有效状态',
    create_time timestamp default CURRENT_TIMESTAMP not null comment '创建时间'
)
    comment '菜单表' charset = utf8mb4;

create table if not exists t_money_detail
(
    id                bigint auto_increment
        primary key,
    user_id           bigint                                   not null comment '用户id',
    related_id        bigint                                   null comment '业务关联id',
    order_no          varchar(50)                              null comment '订单号',
    payment_type      tinyint(2)                               not null comment '收支类型(-1：支出，1：收入，0：非收支记录)',
    amount            decimal(10, 2) default 0.00              not null comment '金额',
    available_balance decimal(10, 2)                           null comment '可用余额',
    freeze_amount     decimal(10, 2) default 0.00              null comment '冻结金额',
    trade_type        tinyint(2)                               not null comment '交易类型',
    type              tinyint(2)     default 0                 not null comment '类型',
    status            tinyint(2)     default 1                 not null comment '状态(1-到账，2-冻结,3-取消)',
    remark            varchar(50)    default ''                null comment '备注',
    create_time       datetime       default CURRENT_TIMESTAMP not null comment '创建时间',
    update_time       datetime                                 null on update CURRENT_TIMESTAMP comment '修改时间'
)
    collate = utf8mb4_bin;

create index idx_create_time
    on t_money_detail (create_time);

create index index1
    on t_money_detail (user_id);

create index index2
    on t_money_detail (payment_type);

create index index3
    on t_money_detail (trade_type);

create table if not exists t_new_user_benefit
(
    id                             bigint                                   not null comment '主键ID,使用userId作为主键',
    type                           tinyint(2)     default 1                 null comment '类型',
    register_benefit_amount        decimal(18, 2) default 0.00              null,
    register_benefit_status        tinyint(2)     default 0                 null comment '注册奖励领取状态',
    invite_benefit_amount          decimal(18, 2) default 0.00              null,
    invite_benefit_status          tinyint(2)     default -1                null comment '邀请码奖励领取状态',
    share_benefit_amount           decimal(18, 2) default 0.00              null,
    share_benefit_status           tinyint(2)     default -1                null comment '分享好友奖励领取状态',
    binding_account_benefit_status tinyint(2)     default 0                 null comment '绑定账号奖励领取状态',
    binding_account_benefit_amount decimal(10, 2) default 0.00              null comment '绑定账号奖励金额',
    agent_benefit_amount           decimal(6, 2)                            null comment '代言人审核通过奖励',
    benefit_register_from_status   tinyint(2)     default 0                 null comment '新用户域名注册奖励领取状态',
    benefit_register_from_amount   decimal(10, 2) default 0.00              null comment '新用户域名注册奖励领取金额',
    create_time                    timestamp      default CURRENT_TIMESTAMP not null comment '创建时间',
    update_time                    timestamp      default CURRENT_TIMESTAMP not null on update CURRENT_TIMESTAMP comment '修改时间',
    primary key (id)
)
    charset = utf8mb4;

create table if not exists t_new_user_benefit_register_from
(
    id            bigint auto_increment
        primary key,
    register_from varchar(256)                         not null,
    amount        decimal(10, 2)                       not null,
    remark        varchar(256)                         null,
    status        tinyint(2) default 1                 not null,
    create_time   datetime   default CURRENT_TIMESTAMP not null,
    update_time   datetime                             null on update CURRENT_TIMESTAMP
)
    collate = utf8mb4_bin;

create table if not exists t_notice
(
    id                 bigint auto_increment comment '主键ID'
        primary key,
    user_id            bigint                               null comment '用户ID(通用公告为0)',
    title              varchar(128)                         null comment '消息标题',
    content            varchar(500)                         null comment '通知内容',
    type               tinyint(2)                           null comment '类型(1-通用公告，2-个人通知)',
    xg_type            tinyint(2) default 1                 null comment '1-amtk，2-mh',
    status             tinyint(2) default 0                 not null comment '状态(0-无效，1-有效)',
    `read`             tinyint(2) default 0                 null comment '0-未读，1-已读',
    template_id        bigint                               null comment '模版的ID，关联t_notice_template',
    effective_duration bigint                               null comment '有效时长，单位毫秒',
    create_time        timestamp  default CURRENT_TIMESTAMP not null comment '创建时间',
    update_time        timestamp  default CURRENT_TIMESTAMP not null comment '修改时间'
)
    charset = utf8mb4;

create index index1
    on t_notice (user_id);

create index index2
    on t_notice (type);

create index index3
    on t_notice (xg_type);

create index index4
    on t_notice (status);

create index index5
    on t_notice (`read`);

create table if not exists t_notice_read
(
    id          bigint auto_increment comment '主键ID'
        primary key,
    user_id     bigint                               null comment '用户ID(通用公告为0)',
    related_id  bigint                               null comment '关联ID',
    type        tinyint(2) default 1                 null comment '类型(1-通用公告，2-个人通知)',
    status      tinyint(2) default 1                 not null comment '状态(0-无效，1-有效)',
    create_time timestamp  default CURRENT_TIMESTAMP not null comment '创建时间',
    update_time timestamp  default CURRENT_TIMESTAMP not null comment '修改时间',
    constraint index1
        unique (user_id, related_id)
)
    charset = utf8mb4;

create index index2
    on t_notice_read (type);

create index index3
    on t_notice_read (user_id);

create index index4
    on t_notice_read (related_id);

create table if not exists t_notice_template
(
    id          bigint auto_increment comment '主键ID'
        primary key,
    code        varchar(50) default ''                not null comment '唯一标示CODE',
    title       varchar(128)                          null comment '模版的标题',
    content     varchar(512)                          null comment '模版的内容',
    remark      varchar(512)                          null comment '备注',
    status      tinyint     default 1                 not null comment '有效状态（0:无效；1:有效）',
    create_time timestamp   default CURRENT_TIMESTAMP not null comment '创建时间'
)
    charset = utf8mb4;

create table if not exists t_operation_log
(
    id             bigint(10) auto_increment comment '主键ID'
        primary key,
    type           tinyint(2) default 1                 null comment '类型（1-Picture,2-PictureType,3-PictureDetail,4-Article,5-ArticleType,6-ArticleContent,7-LotteryRecord,8-LotteryPlan,9-LotteryRecommend）',
    operation_type tinyint(2) default 1                 null comment '1-新增，2-修改，3-删除',
    value          varchar(1000)                        null,
    status         tinyint(2) default 0                 null,
    process        tinyint(2) default 0                 null comment '六六之家',
    process1       tinyint(2) default 0                 null comment '九龙图库',
    process2       tinyint(2) default 0                 null comment '香港图库',
    process3       tinyint(2) default 0                 null comment '新台湾图库',
    process4       tinyint(2) default 0                 null comment '新澳门图库',
    process5       tinyint(2) default 0                 null comment '澳门宝典',
    create_time    timestamp  default CURRENT_TIMESTAMP not null comment '创建时间',
    update_time    timestamp  default CURRENT_TIMESTAMP not null on update CURRENT_TIMESTAMP comment '修改时间'
)
    charset = utf8mb4;

create index index1
    on t_operation_log (status);

create index index2
    on t_operation_log (process);

create index index3
    on t_operation_log (process1);

create index index4
    on t_operation_log (process2);

create index index5
    on t_operation_log (type);

create index index6
    on t_operation_log (process3);

create index index7
    on t_operation_log (process4);

create index index8
    on t_operation_log (process5);

create table if not exists t_operation_record
(
    id                bigint(16) auto_increment
        primary key,
    related_id        text                               null comment '关联id',
    module            varchar(128)                       null,
    description       varchar(256)                       null comment '操作内容',
    operation_user_id bigint                             not null comment '操作人id',
    related_type      tinyint(20)                        null comment '关联类型',
    ip                varchar(64)                        null comment 'ip',
    create_time       datetime default CURRENT_TIMESTAMP not null comment '创建时间',
    update_time       datetime                           null on update CURRENT_TIMESTAMP comment '修改时间'
)
    collate = utf8mb4_bin;

create index index1
    on t_operation_record (create_time);

create index index2
    on t_operation_record (module);

create index index3
    on t_operation_record (operation_user_id);

create index index4
    on t_operation_record (ip);

create table if not exists t_order
(
    id            bigint auto_increment comment '主键ID'
        primary key,
    user_id       bigint                              null comment '用户ID',
    account_id    bigint                              null comment '账户ID',
    order_no      varchar(100)                        null comment '订单号',
    amount        decimal(18, 2)                      null comment '金额',
    freeze_amount decimal(18, 2)                      null comment '收支',
    trade_type    tinyint(2)                          null comment '业务类型',
    status        tinyint(2)                          null comment '状态',
    remark        varchar(500)                        null comment '备注',
    create_time   timestamp default CURRENT_TIMESTAMP not null comment '创建时间',
    update_time   timestamp default CURRENT_TIMESTAMP not null comment '修改时间'
)
    charset = utf8mb4;

create table if not exists t_order_detail
(
    id            bigint auto_increment comment 'ID，自增长'
        primary key,
    user_id       bigint                              not null comment '用户ID',
    business_id   bigint                              null comment '业务ID',
    order_no      varchar(32)                         null comment '订单号',
    order_id      bigint                              null comment '订单ID',
    count         int(10)                             null comment '商品数量',
    price         decimal(18, 2)                      not null comment '价格',
    total_amount  decimal(18, 2)                      null comment '商品总价格',
    product_title varchar(128)                        null comment '商品名称',
    product_id    bigint                              null comment '商品id',
    remark        varchar(128)                        null comment '备注',
    trade_type    tinyint                             null comment '业务类型',
    status        tinyint   default 1                 not null comment '订单状态(0-未交付，1-已交付，2-已退货)',
    create_time   timestamp default CURRENT_TIMESTAMP not null comment '创建时间，默认为当前',
    update_time   timestamp default CURRENT_TIMESTAMP not null comment '修改时间，默认为当前'
)
    comment '订单商品详情' charset = utf8mb4;

create table if not exists t_pay_account
(
    id           bigint                                not null comment 'user_id',
    user_id      bigint                                null comment '用户Id',
    bank         varchar(64)                           not null comment '开户行/微信/支付宝',
    account_no   varchar(64) default ''                not null comment '账号',
    payment_code varchar(200)                          null comment '收款码',
    width        int(10)                               null comment '收款码宽度',
    height       int(10)                               null comment '收款码高度',
    password     varchar(64)                           null comment '帐号的Token',
    account_name varchar(64)                           null comment '账户名',
    remarks      varchar(64)                           null comment '备注',
    status       tinyint(2)  default 1                 not null comment '状态(1:有效;2:无效)',
    create_time  timestamp   default CURRENT_TIMESTAMP not null comment '创建时间',
    update_time  timestamp   default CURRENT_TIMESTAMP not null on update CURRENT_TIMESTAMP comment '更新时间',
    create_by    varchar(32)                           null comment '创建人',
    primary key (id)
)
    charset = utf8mb4;

create table if not exists t_picture
(
    id               bigint(10)                            not null comment '主键ID',
    lottery_type     tinyint(10) default 2                 null comment '1-香港，2-澳门，3-台湾',
    original_id      bigint(10)                            null comment '原始记录ID',
    host_id          bigint(10)  default 1                 null comment '域名ID',
    year             int(4)                                null comment '年份',
    number           int(4)                                null comment '期数',
    picture_type_id  bigint(10)                            null comment '类型ID',
    name             varchar(20)                           null comment '名称',
    keyword          varchar(20)                           null,
    status           tinyint(2)  default 1                 null comment '状态',
    color            tinyint(2)                            null comment '颜色（1-彩色，2-黑白）',
    comment_count    int(10)     default 0                 not null comment '评论数',
    click_count      int(10)     default 0                 not null comment '点击数',
    base_click_count int(10)     default 0                 null comment '点击量基数',
    collect_count    int(10)     default 0                 null,
    thumb_up_count   int(10)     default 0                 not null comment '点赞数',
    type             tinyint(2)  default 0                 null comment '压缩处理次数',
    create_time      datetime    default CURRENT_TIMESTAMP not null comment '创建时间',
    update_time      datetime    default CURRENT_TIMESTAMP not null comment '修改时间',
    primary key (id),
    constraint original_id
        unique (original_id, lottery_type)
)
    charset = utf8mb4;

create index color
    on t_picture (color, keyword);

create index index_lottery_type
    on t_picture (lottery_type);

create index status
    on t_picture (status);

create index year
    on t_picture (year, color, number, picture_type_id, status, lottery_type, name);

create table if not exists t_picture_batch_num
(
    id          bigint(10) auto_increment comment '主键ID'
        primary key,
    batch_num   int(10)                             null comment '批次',
    count       int(10)                             null comment '数量',
    create_time timestamp default CURRENT_TIMESTAMP not null comment '创建时间',
    update_time timestamp default CURRENT_TIMESTAMP not null comment '修改时间'
)
    charset = utf8mb4;

create table if not exists t_picture_detail
(
    id               bigint                               not null comment '主键ID',
    lottery_type     tinyint(2) default 2                 null comment '1-香港，2-澳门，3-台湾',
    host_id          bigint(10) default 1                 not null comment '域名ID',
    type             tinyint(2) default 0                 not null comment '图片类型',
    file_type        tinyint(2) default 1                 null comment '文件类型（1-图片，2-视频）',
    sub_type         tinyint(2)                           null comment '图片子类型，1-通用，2-头像库',
    related_id       bigint                               not null comment '实体ID',
    file_path        varchar(512)                         null comment '类型（）',
    sort             int(4)     default 1                 null comment '排序',
    height           int        default 200               null comment '全尺寸高度',
    width            int        default 200               null comment '全尺寸宽度',
    middle_width     int                                  null comment '中尺寸宽度',
    middle_height    int                                  null comment '中尺寸高度',
    middle_file_path varchar(512)                         null comment '中尺寸路径',
    small_file_path  varchar(512)                         null comment '小尺寸路径',
    small_height     int                                  null comment '小尺寸高度',
    small_width      int                                  null comment '小尺寸宽度',
    title            varchar(255)                         null comment '标题',
    description      varchar(500)                         null comment '描述',
    status           tinyint(2) default 1                 null comment '状态',
    process          tinyint(2) default 0                 null comment '-1处理失败，0-未处理，1-处理完成,2-待压缩，3-待校验',
    create_time      timestamp  default CURRENT_TIMESTAMP not null comment '创建时间',
    update_time      timestamp                            null on update CURRENT_TIMESTAMP comment '修改时间',
    primary key (id),
    constraint type
        unique (type, related_id, sort, lottery_type)
)
    charset = utf8mb4;

create index index1
    on t_picture_detail (sub_type);

create index process
    on t_picture_detail (process, type);

create table if not exists t_picture_series
(
    id          bigint(10) auto_increment comment '主键ID'
        primary key,
    name        varchar(200)                        null comment '名称',
    description varchar(500)                        null comment '描述',
    remark      varchar(500)                        null comment '备注',
    sort        int(10)                             null comment '排序的字段，越小排序在前',
    status      tinyint(2)                          null comment '状态',
    create_time timestamp default CURRENT_TIMESTAMP not null comment '创建时间',
    update_time timestamp default CURRENT_TIMESTAMP not null comment '修改时间'
)
    charset = utf8mb4;

create table if not exists t_picture_sync_job
(
    id               bigint(10) auto_increment comment '主键ID'
        primary key,
    max_original_id  bigint                               null,
    min_original_id  bigint                               null,
    picture_type_ids varchar(200)                         null comment '类型ID',
    number           int(4)                               null comment '期数',
    year             int(4)                               null comment '年份',
    color            tinyint(2)                           null comment '颜色',
    job_type         tinyint(2) default 1                 null comment '1-更新，2-删除, 3-新增',
    status           tinyint(2) default 0                 null comment '0-待执行，1-正在执行，2-执行成功，3-执行失败',
    result_count     int(10)                              null comment '操作数据量',
    start_time       timestamp                            null comment '开始时间',
    end_time         timestamp                            null comment '结束时间',
    create_time      timestamp  default CURRENT_TIMESTAMP not null comment '创建时间',
    update_time      timestamp  default CURRENT_TIMESTAMP not null on update CURRENT_TIMESTAMP comment '修改时间'
)
    charset = utf8mb4;

create table if not exists t_picture_type
(
    id                 bigint(10) auto_increment comment '主键ID',
    lottery_type       tinyint(10) default 2                 null comment '1-香港，2-澳门，3-台湾',
    original_id        bigint(10)                            null comment '原始记录ID',
    host_id            bigint(10)  default 1                 null comment '域名ID',
    batch_num          int(10)     default 1                 null comment '批次',
    current_number     int(10)                               null comment '当前期数',
    name               varchar(200)                          null comment '名称',
    letter             varchar(100)                          null comment '拼音',
    status             tinyint(2)  default 1                 null comment '状态',
    type               tinyint(2)                            null comment '类型',
    recommend          tinyint(2)  default 0                 null comment '1-推荐，0-不推荐',
    display_picture_id bigint(10)                            null comment '默认展示的图片ID',
    sort               int(10)     default 1000              null comment '排序字段，越小排序越在前面',
    collection_count   int(10)     default 0                 null comment '收藏次数',
    color              tinyint(2)  default 1                 not null comment '颜色（1-彩色，2-黑白）',
    remark             varchar(500)                          null comment '备注',
    create_time        timestamp   default CURRENT_TIMESTAMP not null comment '创建时间',
    update_time        timestamp                             null on update CURRENT_TIMESTAMP comment '修改时间',
    uuid               varchar(50)                           null,
    keyword            varchar(50)                           null,
    primary key (id, color),
    constraint uuid
        unique (color, keyword, lottery_type)
)
    charset = utf8mb4;

create table if not exists t_picture_type_click
(
    id              bigint                               not null comment '主键ID',
    user_id         bigint                               null comment '用户ID',
    picture_type_id bigint                               null comment '图片类型ID',
    count           int(10)    default 0                 null comment '点击数量',
    status          tinyint(2) default 1                 null comment '状态',
    type            tinyint(2)                           null comment '类型',
    create_time     timestamp  default CURRENT_TIMESTAMP not null comment '创建时间',
    update_time     timestamp  default CURRENT_TIMESTAMP not null comment '修改时间',
    primary key (id),
    constraint user_id
        unique (user_id, picture_type_id)
)
    charset = utf8mb4;

create table if not exists t_picture_type_keyword
(
    id              bigint(10) auto_increment comment '主键ID'
        primary key,
    color           tinyint(2)  null,
    keyword         varchar(50) null,
    picture_type_id bigint(10)  null,
    constraint color
        unique (color, keyword)
)
    charset = utf8mb4;

create table if not exists t_platform_stat_day
(
    id                         bigint                                   not null comment 'yyyyMM',
    stat_date                  int(10)                                  null comment 'yyyyMMdd',
    register_count             int            default 0                 null comment '注册人数',
    invite_count               int            default 0                 null comment '邀请人数',
    withdraw_amount            decimal(18, 2) default 0.00              null comment '提现金额',
    exchange_amount            decimal(18, 2) default 0.00              null comment '兑换金额',
    red_packet_amount          decimal(18, 2) default 0.00              null comment '每日红包金额',
    register_reward_amount     decimal(18, 2) default 0.00              null comment '注册奖励',
    invite_reward_amount       decimal(18, 2) default 0.00              null comment '邀请奖励',
    help_reward_amount         decimal(18, 2) default 0.00              null comment '发起助力',
    provide_help_reward_amount decimal(18, 2) default 0.00              null comment '提供助力',
    agent_amount               decimal(18, 2) default 0.00              null comment '代言人',
    brokerage_amount           decimal(18, 2) default 0.00              null comment '佣金',
    create_time                timestamp      default CURRENT_TIMESTAMP null comment '创建时间',
    update_time                timestamp      default CURRENT_TIMESTAMP null comment '修改时间',
    primary key (id),
    constraint stat_date
        unique (stat_date)
)
    charset = utf8mb4;

create table if not exists t_platform_stat_month
(
    id                 bigint                                   not null comment 'yyyyMM',
    stat_date          int(10)                                  null comment 'yyyyMM',
    register_count     int            default 0                 null comment '注册人数',
    effective_count    int            default 0                 null comment '有效人数',
    base_salary_amount decimal(18, 2) default 0.00              null comment '基础工资',
    withdraw_amount    decimal(18, 2) default 0.00              null comment '提现金额',
    exchange_amount    decimal(18, 2) default 0.00              null comment '兑换金额',
    available_balance  decimal(18, 2) default 0.00              null comment '可用余额',
    create_time        timestamp      default CURRENT_TIMESTAMP null comment '创建时间',
    update_time        timestamp      default CURRENT_TIMESTAMP null comment '修改时间',
    primary key (id),
    constraint stat_date
        unique (stat_date)
)
    charset = utf8mb4;

create table if not exists t_pop_notice
(
    id                  bigint auto_increment comment 'id，自增长ID'
        primary key,
    pop_type            tinyint(2)   default 1                 null comment '弹窗类型，1-通用弹窗，2-公司入款提醒弹窗',
    xg_type             tinyint(2)   default 1                 null comment '1-amtk，2-mh',
    title               varchar(256) default ''                null comment '标题',
    content             varchar(512) default ''                null comment '内容',
    start_time          timestamp    default CURRENT_TIMESTAMP not null,
    end_time            timestamp    default CURRENT_TIMESTAMP not null comment '结束时间',
    url                 varchar(128)                           null,
    type                tinyint(2)   default 0                 not null comment '跳转类型：0不跳，1跳外部url，2跳内部url，3跳购彩，4跳优惠活动，5跳活动中心',
    bg_file_path        varchar(512)                           null comment '背景图片的路径',
    height              int                                    null comment '背景图片的高度',
    width               int                                    null comment '背景图片的宽度',
    sort                int          default 100               not null comment '排序，正序',
    status              tinyint      default 1                 not null comment '有效状态',
    is_pop_index        tinyint(2)   default 1                 null comment '首页是否弹',
    is_pop_game_list    tinyint(2)   default 1                 null comment '游戏列表是否弹',
    is_pop_account_list tinyint(2)   default 1                 null comment '充值账户列表是否弹',
    create_time         timestamp    default CURRENT_TIMESTAMP not null comment '创建时间',
    update_time         timestamp    default CURRENT_TIMESTAMP not null on update CURRENT_TIMESTAMP comment '更新时间'
)
    comment '弹窗公告记录表' charset = utf8mb4;

create table if not exists t_professional_apply
(
    id          bigint auto_increment
        primary key,
    user_id     bigint                             not null,
    status      tinyint(2)                         null comment '状态，0-审核中，1-通过，2-不通过',
    remark      varchar(256)                       null comment '备注',
    create_time datetime default CURRENT_TIMESTAMP not null,
    update_time datetime                           null on update CURRENT_TIMESTAMP
)
    collate = utf8mb4_bin;

create index index1
    on t_professional_apply (user_id);

create index index5
    on t_professional_apply (status);

create table if not exists t_professional_election
(
    id                bigint auto_increment
        primary key,
    lottery_type      tinyint(2)                           not null comment '彩种',
    type              tinyint(2)                           not null comment '1-特码竞选，2-特肖竞选',
    title             varchar(64)                          not null comment '标题',
    election_criteria varchar(64)                          not null comment '当选标准',
    description       text                                 not null comment '描述',
    begin_number      int                                  not null comment '开始期数',
    end_number        int                                  not null comment '结束期数',
    total_number      int                                  not null comment '总期数',
    win_count         int                                  not null comment '需中期数',
    status            tinyint(2) default 0                 not null comment '0-待开始，1-进行中，2-已结束',
    create_time       datetime   default CURRENT_TIMESTAMP not null,
    update_time       datetime                             null on update CURRENT_TIMESTAMP
)
    collate = utf8mb4_bin;

create index index1
    on t_professional_election (type);

create index index2
    on t_professional_election (lottery_type);

create index index3
    on t_professional_election (status);

create table if not exists t_professional_election_apply
(
    id                       bigint auto_increment
        primary key,
    user_id                  bigint                             not null,
    professional_election_id bigint                             null,
    number                   int                                null,
    description              varchar(256)                       null,
    type                     tinyint(2)                         null comment '1-特码竞选，2-特肖竞选',
    status                   tinyint(2)                         null comment '状态，0-审核中，1-通过，2-不通过',
    create_time              datetime default CURRENT_TIMESTAMP not null,
    update_time              datetime                           null on update CURRENT_TIMESTAMP
)
    collate = utf8mb4_bin;

create index index1
    on t_professional_election_apply (user_id);

create index index2
    on t_professional_election_apply (professional_election_id);

create index index3
    on t_professional_election_apply (number);

create index index4
    on t_professional_election_apply (type);

create index index5
    on t_professional_election_apply (status);

create table if not exists t_profile
(
    id            bigint auto_increment comment '主键ID(根据push_id去hash值)'
        primary key,
    user_id       bigint(10)                          null comment '用户ID',
    device_id     varchar(128)                        null comment '手机的唯一设备ID',
    push_id       varchar(100)                        null comment '安卓推送标识',
    os_type       tinyint(2)                          null comment '设备类型（1-安卓，2-ios）',
    model         varchar(100)                        null comment '手机型号',
    register_time timestamp                           null comment '注册时间',
    create_time   timestamp default CURRENT_TIMESTAMP not null comment '创建时间',
    update_time   timestamp default CURRENT_TIMESTAMP not null on update CURRENT_TIMESTAMP comment '修改时间'
)
    charset = utf8mb4;

create index day
    on t_profile (user_id, push_id);

create table if not exists t_profile_bak_1
(
    id            bigint auto_increment comment '主键ID(根据push_id去hash值)'
        primary key,
    user_id       bigint(10)                          null comment '用户ID',
    device_id     varchar(128)                        null comment '手机的唯一设备ID',
    push_id       varchar(100)                        null comment '安卓推送标识',
    os_type       tinyint(2)                          null comment '设备类型（1-安卓，2-ios）',
    model         varchar(100)                        null comment '手机型号',
    register_time timestamp                           null comment '注册时间',
    create_time   timestamp default CURRENT_TIMESTAMP not null comment '创建时间',
    update_time   timestamp default CURRENT_TIMESTAMP not null on update CURRENT_TIMESTAMP comment '修改时间'
)
    charset = utf8mb4;

create index day
    on t_profile_bak_1 (user_id, push_id);

create table if not exists t_promote_record
(
    id          varchar(20)                          not null,
    mobile      varchar(20)                          not null comment '手机号',
    invite_code varchar(20)                          not null comment '邀请码',
    status      tinyint(2) default 1                 not null comment '1-可用，0-不可用',
    create_time datetime   default CURRENT_TIMESTAMP not null,
    update_time datetime                             null on update CURRENT_TIMESTAMP,
    primary key (id)
)
    collate = utf8mb4_bin;

create table if not exists t_push
(
    id              bigint(10) auto_increment comment '主键ID'
        primary key,
    user_id         bigint                               null comment '用户id',
    title           varchar(200)                         null comment '标题',
    content         varchar(2000)                        null comment '内容',
    status          tinyint(2) default 1                 null comment '状态(1-未开始，2-正在推送，3-推送完成)',
    total_count     int(10)                              null comment '推送总数',
    success_count   int(10)                              null comment '发送成功数目',
    reach_count     int(10)                              null comment '到达数目',
    type            tinyint(2) default 2                 null comment '类型(1-个推，2-总推)',
    begin_time      timestamp                            null comment '开始时间',
    end_time        timestamp                            null comment '结束时间',
    create_time     timestamp  default CURRENT_TIMESTAMP not null comment '创建时间',
    update_time     timestamp  default CURRENT_TIMESTAMP not null comment '修改时间',
    create_user_id  bigint(10)                           null comment '创建者ID',
    android_task_id varchar(200)                         null,
    ios_task_id     varchar(200)                         null
)
    charset = utf8mb4;

create index index1
    on t_push (user_id);

create index index2
    on t_push (type);

create table if not exists t_push_record
(
    id             bigint(10) auto_increment comment '主键ID'
        primary key,
    push_id        binary(10)                           null comment '推送ID',
    target_code    varchar(100)                         null comment '被推送用户code',
    user_id        bigint(10)                           null comment '被推送用户ID',
    content        varchar(2000)                        null comment '内容',
    status         tinyint(2) default 0                 null comment '状态(0-草稿，1-未开始，2-正在推送，3-推送完成)',
    success        bit                                  null comment '发送成功',
    reach          bit                                  null comment '到达',
    type           tinyint(2)                           null comment '类型',
    plan_push_time timestamp                            null comment '计划推送时间',
    real_plan_time timestamp                            null comment '真实推送时间',
    create_time    timestamp  default CURRENT_TIMESTAMP not null comment '创建时间',
    update_time    timestamp  default CURRENT_TIMESTAMP not null comment '修改时间'
)
    charset = utf8mb4;

create table if not exists t_recharge_notify
(
    id          bigint auto_increment comment 'ID，自增长'
        primary key,
    order_no    varchar(50)                         null,
    type        tinyint(2)                          null comment '1-兑换',
    result      varchar(1000)                       null,
    status      tinyint(2)                          null comment '0-失败，1-成功',
    create_time timestamp default CURRENT_TIMESTAMP not null comment '创建时间，默认为当前',
    update_time timestamp default CURRENT_TIMESTAMP not null on update CURRENT_TIMESTAMP comment '修改时间，默认为当前',
    constraint order_no
        unique (order_no)
)
    comment '提现' charset = utf8mb4;

create table if not exists t_recharge_record
(
    id                bigint auto_increment
        primary key,
    user_id           bigint                                   not null comment '用户id',
    bank_card_no      varchar(50)                              null comment '卡号',
    account_id        bigint                                   null comment '公司账户id',
    amount            decimal(10, 2) default 0.00              not null comment '存款金额',
    name              varchar(20)                              null comment '存款人姓名',
    type              tinyint(2)                               not null comment '充值方式',
    manual_type       tinyint(2)                               null comment '人工存提类型',
    manual_trade_type tinyint(2)                               null comment '人工存提交易类型',
    order_no          varchar(100)                             not null comment '订单号',
    status            tinyint(2)     default 0                 not null comment '0-处理中，1-充值成功，2-充值失败',
    payment_name      varchar(128)                             null comment '支付名称',
    payment_title     varchar(128)                             null comment '支付方式',
    code              varchar(128)                             null comment 'code',
    operation_user_id bigint                                   null comment '操作者',
    remark            varchar(150)                             null comment '备注',
    create_time       datetime       default CURRENT_TIMESTAMP not null comment '创建时间',
    update_time       datetime                                 null on update CURRENT_TIMESTAMP comment '修改时间'
)
    collate = utf8mb4_bin;

create index index1
    on t_recharge_record (user_id);

create index index2
    on t_recharge_record (type);

create index index3
    on t_recharge_record (create_time);

create index index_manual_type
    on t_recharge_record (manual_type);

create index index_status
    on t_recharge_record (status);

create table if not exists t_red_packet_config
(
    id          bigint auto_increment comment 'ID，自增长'
        primary key,
    type        tinyint(2) default 1                 not null comment '奖品类型(1-每日红包，2-助力，3-被助力)',
    min_count   int(10)                              null comment '数量下限（不包含）',
    max_count   int(10)                              null comment '数量上限（包含）',
    min_amount  decimal(10, 2)                       null comment '金额下限（不包含）',
    max_amount  decimal(10, 2)                       null comment '金额上限（包含）',
    rate        decimal(10, 6)                       null comment '中奖概率',
    sort        int(4)                               null comment '顺序',
    status      tinyint    default 1                 not null comment '状态 1为有效 0为无效 默认为1',
    create_time timestamp  default CURRENT_TIMESTAMP not null comment '创建时间，默认为当前',
    update_time timestamp  default CURRENT_TIMESTAMP not null on update CURRENT_TIMESTAMP comment '修改时间，默认为当前'
)
    comment '提现' charset = utf8mb4;

create table if not exists t_red_packet_record
(
    id          bigint                               not null comment 'yyyyMMdd + userId作为主键',
    type        tinyint(2) default 1                 null comment '类型',
    amount      decimal(10, 2)                       null comment '红包金额',
    status      tinyint(2) default 1                 null,
    user_id     bigint                               null comment '用户ID',
    create_time timestamp  default CURRENT_TIMESTAMP not null comment '创建时间',
    update_time timestamp  default CURRENT_TIMESTAMP not null on update CURRENT_TIMESTAMP comment '修改时间',
    primary key (id)
)
    charset = utf8mb4;

create table if not exists t_report
(
    id          bigint(10)                           not null comment '主键ID',
    user_id     bigint(10)                           null comment '用户ID',
    type        tinyint(2)                           null comment '类型',
    related_id  bigint                               null comment '关联ID',
    remark      varchar(512)                         null,
    status      tinyint(2) default 1                 null comment '状态(0-待审核，1-审核通过，2-审核拒绝)',
    create_time timestamp  default CURRENT_TIMESTAMP not null comment '创建时间',
    update_time timestamp  default CURRENT_TIMESTAMP not null on update CURRENT_TIMESTAMP comment '修改时间',
    primary key (id)
)
    charset = utf8mb4;

create table if not exists t_role
(
    id          bigint auto_increment comment '主键ID'
        primary key,
    name        varchar(32)                          null comment '角色名称',
    status      tinyint(2) default 1                 not null comment '有效状态',
    remark      varchar(512)                         null comment '备注',
    create_time timestamp  default CURRENT_TIMESTAMP not null comment '创建时间'
)
    charset = utf8mb4;

create table if not exists t_role_authority
(
    id           bigint auto_increment comment '主键ID'
        primary key,
    role_id      bigint null comment '角色ID',
    authority_id bigint null comment '权限ID'
)
    charset = utf8mb4;

create table if not exists t_sensitive_word
(
    id        bigint auto_increment
        primary key,
    content   text collate utf8_bin not null,
    type      tinyint               not null,
    operation int                   not null
)
    charset = utf8;

create table if not exists t_share_info
(
    id          bigint auto_increment comment '主键ID'
        primary key,
    title       varchar(128)                        null comment '标题',
    content     varchar(256)                        null comment '内容',
    icon        varchar(128)                        null comment '分享出去的logo的icon地址',
    url         varchar(128)                        null comment '分享的url',
    type        tinyint   default 1                 not null comment '1-普通分享；2-每日助力活动',
    remark      varchar(255)                        null comment '备注',
    status      tinyint   default 1                 not null comment '有效状态，1-有效；0-无效',
    create_time timestamp default CURRENT_TIMESTAMP not null comment '创建时间',
    update_time timestamp default CURRENT_TIMESTAMP not null on update CURRENT_TIMESTAMP comment '更新时间'
)
    charset = utf8mb4;

create table if not exists t_share_record
(
    id           bigint(10) auto_increment comment '主键ID'
        primary key,
    user_id      bigint(10)                           null comment '用户ID',
    jpush_id     varchar(50)                          null comment '极光ID',
    type         tinyint(2)                           null comment '类型(0-其他，1-图片，2-发现,3-六合公式，4-资料，[5-高手], 6-评论，7-意见反馈, 8-幽默竞猜，9-助力)',
    related_id   bigint(10)                           null comment '关联ID',
    share_type   tinyint(2)                           null comment '1-链接，2-图片',
    channel_type tinyint(2)                           null comment '1-微信好友，2-微信朋友圈，3-短信',
    title        varchar(255)                         null comment '标题',
    content      varchar(1000)                        null comment '内容',
    url          varchar(1000)                        null comment '链接',
    status       tinyint(2) default 1                 null comment '状态',
    create_time  timestamp  default CURRENT_TIMESTAMP not null comment '创建时间',
    update_time  timestamp  default CURRENT_TIMESTAMP not null comment '修改时间'
)
    charset = utf8mb4;

create index `type-related_id-user_id`
    on t_share_record (type, related_id, user_id);

create table if not exists t_show
(
    id               bigint(10) auto_increment comment '主键ID'
        primary key,
    lottery_type     tinyint(11) default 2                 null,
    user_id          bigint(10)                            null comment '用户ID',
    type             tinyint(2)  default 1                 null comment '发现类型,1-图片，2-视频',
    description      varchar(2000)                         null comment '描述',
    title            varchar(2000)                         null comment '标题',
    thumb_up_count   int(10)     default 0                 not null comment '点赞数',
    comment_count    int(10)     default 0                 not null comment '评论数',
    click_count      int(10)     default 0                 null comment '点击次数',
    base_click_count int(10)     default 0                 null comment '点击次数基数',
    verify_id        bigint                                null comment '审核人ID',
    verify_status    tinyint(2)                            null comment '状态(0-审核中，1-审核通过，2-审核不通过)',
    reason           varchar(255)                          null comment '审核结果',
    commend          tinyint(2)  default 0                 not null comment '是否推荐（0:不推荐；1:推荐）',
    sort             int         default 10000             not null comment '排序，正向排序：先按照sort，再按照时间排序。',
    status           tinyint(2)  default 1                 null comment '状态',
    create_time      timestamp   default CURRENT_TIMESTAMP not null comment '创建时间',
    update_time      timestamp   default CURRENT_TIMESTAMP not null on update CURRENT_TIMESTAMP comment '修改时间'
)
    charset = utf8mb4;

create index status
    on t_show (status, verify_status, commend);

create index status_2
    on t_show (status, verify_status, user_id);

create table if not exists t_sms_record
(
    id          bigint(10) auto_increment comment '主键ID'
        primary key,
    user_id     bigint(10)                           null comment '被推送用户ID',
    mobile      varchar(20)                          null comment '手机号码',
    content     varchar(2000)                        null comment '内容',
    status      tinyint(2) default 0                 null comment '状态(0-草稿，1-未开始，2-正在推送，3-推送完成)',
    success     tinyint(1)                           null comment '发送成功',
    reach       tinyint(1)                           null comment '到达',
    type        tinyint(2)                           null comment '类型(1-注册，2-找回密码)',
    remark      varchar(2000)                        null comment '备注',
    create_time timestamp  default CURRENT_TIMESTAMP not null comment '创建时间',
    update_time timestamp  default CURRENT_TIMESTAMP not null on update CURRENT_TIMESTAMP comment '修改时间'
)
    charset = utf8mb4;

create index index1
    on t_sms_record (mobile);

create index mobile
    on t_sms_record (mobile, status, create_time);

create table if not exists t_thumb_down
(
    id          varchar(30)                          not null comment '主键ID',
    user_id     bigint(10)                           null comment '用户ID',
    type        tinyint(2)                           null comment '类型(1-图片，2-发现，3-评论)',
    related_id  bigint(10)                           null comment '关联ID',
    status      tinyint(2) default 1                 null comment '状态',
    create_time timestamp  default CURRENT_TIMESTAMP not null comment '创建时间',
    update_time timestamp  default CURRENT_TIMESTAMP not null comment '修改时间',
    primary key (id),
    constraint `type-related_id-user_id`
        unique (type, related_id, user_id)
)
    charset = utf8mb4;

create table if not exists t_thumb_up
(
    id          varchar(30)                          not null comment '主键ID',
    user_id     bigint(10)                           null comment '用户ID',
    type        tinyint(2)                           null comment '类型(1-图片，2-发现，3-评论)',
    related_id  bigint(10)                           null comment '关联ID',
    status      tinyint(2) default 1                 null comment '状态',
    create_time timestamp  default CURRENT_TIMESTAMP not null comment '创建时间',
    update_time timestamp  default CURRENT_TIMESTAMP not null comment '修改时间',
    primary key (id),
    constraint `type-related_id-user_id`
        unique (type, related_id, user_id)
)
    charset = utf8mb4;

create table if not exists t_tmp_login_record
(
    id          bigint(10) auto_increment comment '主键ID'
        primary key,
    user_id     bigint(10)                          null comment '用户ID',
    create_time timestamp default CURRENT_TIMESTAMP not null comment '创建时间'
)
    charset = utf8mb4;

create table if not exists t_tool_record
(
    id          varchar(50)                         not null comment '主键ID',
    profile_id  bigint                              null,
    result      varchar(255)                        null,
    param       varchar(255)                        null,
    user_id     bigint(10)                          null comment '用户ID',
    push_id     varchar(100)                        null comment '安卓推送标识',
    type        tinyint(2)                          null comment '1-恋人特码，2-生肖卡牌，3-摇一摇，4-玄机锦囊，5-幸运摇奖，6-波肖转盘，7-搅珠日期，8-天际测算，9-条码助手',
    create_time timestamp default CURRENT_TIMESTAMP not null comment '创建时间',
    update_time timestamp default CURRENT_TIMESTAMP not null on update CURRENT_TIMESTAMP comment '修改时间',
    primary key (id)
)
    charset = utf8mb4;

create table if not exists t_umeng_info
(
    id                 bigint(10) auto_increment comment '主键ID'
        primary key,
    user_id            bigint(10)                           null comment '用户ID',
    status             tinyint(2) default 1                 null comment '状态',
    type               tinyint(2)                           null comment '类型（1:后台管理员；2:app用户）',
    umeng_device_token varchar(100)                         null comment '安卓推送标识',
    invite_code        varchar(100)                         null comment '邀请码',
    os_type            tinyint(2)                           null comment '0-安卓，1-iOS',
    create_time        timestamp  default CURRENT_TIMESTAMP not null comment '创建时间',
    update_time        timestamp  default CURRENT_TIMESTAMP not null on update CURRENT_TIMESTAMP comment '修改时间'
)
    charset = utf8mb4;

create table if not exists t_user_activity_record
(
    id          bigint(128)                        not null comment '格式， activityId+user_id ',
    activity_id bigint                             not null comment '活动id',
    amount      decimal(6, 2)                      null comment '奖励金额',
    user_id     bigint                             not null comment '用户id',
    status      tinyint  default 0                 not null comment '奖励领取状态，0-未领取，1-已领取,-1-无效',
    create_time datetime default CURRENT_TIMESTAMP not null comment '创建时间',
    update_time datetime                           null on update CURRENT_TIMESTAMP comment '修改时间',
    primary key (id)
)
    charset = utf8mb4;

create index index1
    on t_user_activity_record (activity_id, user_id, status);

create index index2
    on t_user_activity_record (user_id);

create table if not exists t_user_bank
(
    id               bigint(10)                          not null comment '主键ID',
    user_id          bigint(10)                          null comment '用户id',
    bank_card        varchar(32)                         null comment '银行卡号',
    bank_name        varchar(32)                         null comment '银行名',
    bank_belong_path varchar(128)                        null comment '开户行所在',
    bank_username    varchar(32)                         null comment '银行卡所属人',
    trans_password   varchar(32)                         null comment '交易密码',
    remarks          varchar(255)                        null comment '备注',
    create_time      timestamp default CURRENT_TIMESTAMP not null comment '创建时间',
    update_time      timestamp default CURRENT_TIMESTAMP not null on update CURRENT_TIMESTAMP comment '修改时间',
    primary key (id)
)
    charset = utf8mb4;

create table if not exists t_user_bank_copy1
(
    id               bigint(10)                          not null comment '主键ID',
    user_id          bigint(10)                          null comment '用户id',
    bank_card        varchar(32)                         null comment '银行卡号',
    bank_name        varchar(32)                         null comment '银行名',
    bank_belong_path varchar(128)                        null comment '开户行所在',
    bank_username    varchar(32)                         null comment '银行卡所属人',
    trans_password   varchar(32)                         null comment '交易密码',
    remarks          varchar(255)                        null comment '备注',
    create_time      timestamp default CURRENT_TIMESTAMP not null comment '创建时间',
    update_time      timestamp default CURRENT_TIMESTAMP not null on update CURRENT_TIMESTAMP comment '修改时间',
    primary key (id)
)
    charset = utf8mb4;

create table if not exists t_user_behavior
(
    id               varchar(30)                          not null comment '主键ID',
    user_id          bigint                               null comment '用户ID',
    related_id       bigint                               null comment '关联ID',
    click_count      int(10)    default 0                 null comment '点击数量',
    thumb_up_count   int(10)    default 0                 null comment '点赞数量',
    comment_count    int(10)    default 0                 null comment '评论数量',
    collection_count int(10)    default 0                 null comment '收藏数量',
    status           tinyint(2) default 1                 null comment '状态',
    type             tinyint(2)                           null comment '类型（1-图片，2-发现,3-交流，4-资料，5-高手，6-评论, 7-图片类型）',
    create_time      timestamp  default CURRENT_TIMESTAMP not null comment '创建时间',
    update_time      timestamp  default CURRENT_TIMESTAMP not null comment '修改时间',
    primary key (id),
    constraint user_id
        unique (user_id, related_id, type)
)
    charset = utf8mb4;

create table if not exists t_user_behavior_month_stat
(
    id              bigint(32)                          not null comment 'yyyyMM + userId作为主键',
    user_id         bigint(32)                          null comment '用户id',
    month           int(8)                              null comment 'yyyyMM',
    publish_count   int(8)    default 0                 null comment '发帖数量',
    new_fans_count  int(8)    default 0                 null comment '新增粉丝数量',
    share_count     int(8)    default 0                 null comment '分享次数',
    invite_count    int(8)    default 0                 null comment '邀请新增有效用户数量',
    login_day_count int(8)    default 0                 null comment '登录天数',
    exchange_count  int(8)    default 0                 null comment '兑换次数',
    create_time     timestamp default CURRENT_TIMESTAMP null comment '创建时间',
    update_time     timestamp default CURRENT_TIMESTAMP null on update CURRENT_TIMESTAMP comment '更新时间',
    primary key (id)
)
    charset = utf8mb4;

create index user_id
    on t_user_behavior_month_stat (month);

create table if not exists t_user_behavior_stat
(
    id                     bigint                                   not null comment '使用userId做主键',
    user_id                bigint                                   null comment '用户ID',
    click_count            int(10)        default 0                 null comment '点击数量',
    thumb_up_count         int(10)        default 0                 null comment '点赞数量',
    thumb_up_ed_count      int(10)        default 0                 null comment '被点赞数',
    comment_count          int(10)        default 0                 null comment '评论数量',
    commented_count        int(10)        default 0                 null comment '被评论数',
    collect_count          int(10)        default 0                 null comment '收藏数量',
    publish_article_count  int(10)        default 0                 null comment '发文章数',
    publish_show_count     int(10)        default 0                 null comment '发现数',
    fans_count             int(10)        default 0                 null comment '粉丝数(被关注)',
    share_count            int(10)        default 0                 null comment '分享数',
    available_balance      decimal(10, 2) default 0.00              null comment '账户余额',
    send_red_packet_amount decimal(10, 2) default 0.00              null comment '发红包数',
    report_count           int(10)        default 0                 null comment '有效举报数',
    help_count             int(10)        default 0                 null comment '助力数',
    concern_count          int(10)        default 0                 null comment '关注数',
    invite_count           int(10)        default 0                 null comment '邀请数',
    status                 tinyint(2)     default 1                 null comment '状态',
    type                   tinyint(2)     default 1                 null comment '类型（备用）',
    create_time            timestamp      default CURRENT_TIMESTAMP not null comment '创建时间',
    update_time            timestamp      default CURRENT_TIMESTAMP not null comment '修改时间',
    primary key (id),
    constraint user_id
        unique (user_id, type)
)
    charset = utf8mb4;

create table if not exists t_user_category
(
    id                           bigint auto_increment
        primary key,
    name                         varchar(50)                          not null comment '名称',
    register_begin_time          datetime                             null comment '注册开始时间',
    register_end_time            datetime                             null comment '注册结束时间',
    recharge_count               int                                  null comment '存款次数，-1表示不限制',
    recharge_total_amount        decimal(10, 2)                       null comment '存款总额，-1表示不限制',
    recharge_max_amount          decimal(10, 2)                       null comment '最大存款额度，-1表示不限制',
    total_cost_amount            decimal(10, 2)                       null comment '线下总打码',
    withdraw_count               int                                  null comment '提款次数，-1表示不限制',
    withdraw_amount              decimal(10, 2)                       null comment '提款总额，-1表示不限制',
    available                    tinyint(2) default 1                 null comment '是否启用',
    locked                       tinyint(2) default 0                 null comment '是否锁定',
    is_default                   tinyint(2)                           null comment '是否默认层级,1-是，0-否',
    allowed_bet                  tinyint(2) default 1                 not null comment '是否允许下注，1-是，0-否',
    allowed_withdraw             tinyint(2) default 1                 null comment '是否允许提现，1-是，0-否',
    allowed_balance_transfer_out tinyint(2) default 1                 null comment '是否允许资金转出，1-是，0-否',
    remark                       varchar(128)                         null comment '备注',
    create_time                  datetime   default CURRENT_TIMESTAMP not null comment '创建时间',
    update_time                  datetime                             null on update CURRENT_TIMESTAMP comment '修改时间'
)
    collate = utf8mb4_bin;

create table if not exists t_user_change_record
(
    id           bigint auto_increment comment '自增主键'
        primary key,
    user_id      bigint                               not null comment '用户ID',
    related_id   varchar(30)                          null comment '关联ID',
    type         tinyint(2) default 2                 null comment '类型(1-修改昵称，2-解绑账号)',
    befor_count  int(10)                              null comment '修改前次数',
    after_count  int(10)                              null comment '修改后次数',
    before_value varchar(255)                         null comment '修改前账号',
    after_value  varchar(255)                         null comment '修改后账号',
    status       tinyint(2) default 1                 not null comment '状态，默认1',
    create_time  timestamp  default CURRENT_TIMESTAMP not null comment '创建时间，默认为当前',
    update_time  timestamp  default CURRENT_TIMESTAMP not null on update CURRENT_TIMESTAMP comment '修改时间，默认为当前'
)
    comment '佣金' charset = utf8mb4;

create table if not exists t_user_effective_month
(
    id             bigint(32)                          not null comment 'yyyyMM + userId作为主键',
    user_id        bigint(32)                          null comment '用户id',
    month          int(8)                              null comment 'yyyyMM',
    effective      tinyint(2)                          null comment '有效用户(1)',
    effective_time timestamp                           null comment '有效开始时间',
    create_time    timestamp default CURRENT_TIMESTAMP null comment '创建时间',
    update_time    timestamp default CURRENT_TIMESTAMP null on update CURRENT_TIMESTAMP comment '更新时间',
    primary key (id)
)
    charset = utf8mb4;

create index user_id
    on t_user_effective_month (month);

create table if not exists t_user_extend
(
    id                            bigint(10)                           not null comment '主键ID',
    ip                            varchar(128)                         null comment 'IP地址',
    same_ip                       tinyint(2) default 0                 not null comment '是否有相同的IP地址：1有；0:无',
    device_id                     varchar(128)                         null comment '手机的唯一设备ID',
    model                         varchar(200)                         null comment '手机型号',
    status                        tinyint(2) default 1                 null comment '状态',
    push_id                       varchar(100)                         null comment '安卓推送标识',
    os_type                       tinyint(2)                           null comment '0-安卓，1-iOS',
    comment_status                tinyint(2) default 1                 not null comment '是否允许评论（1-允许，0-不允许）',
    publish                       tinyint(2) default 0                 not null comment '发布审核（-1黑名单，0-随全局状态，1-白名单）',
    chat_enter_status             tinyint(2) default 1                 not null comment '1-允许进入聊天室，0-不允许进入聊天室',
    chat_speak_status             tinyint(2) default 1                 not null comment '1-允许发言，0-不允许发言',
    code                          varchar(16)                          null comment '邀请码',
    qr_code                       varchar(128)                         null comment '我的推广二维码',
    level                         int(10)    default 1                 null comment '用户等级，默认为1级',
    user_category                 bigint     default 1                 null comment '用户层级',
    concern_count                 int(10)    default 0                 null comment '关注数',
    platform_id                   bigint                               null comment '兑换平台ID',
    platform_account_no           varchar(50)                          null comment '兑换平台账号',
    bg_account_no                 bigint(50)                           null comment 'bg平台账号',
    agent                         tinyint(2) default 0                 null comment '0-非代言人，1-代言人，2-审核中',
    vip                           tinyint(2) default 0                 null comment '0-非VIP，1-VIP',
    vip_end_time                  timestamp                            null comment 'vip结束时间',
    total_change_nickname_count   int(10)    default 0                 null comment '修改昵称总次数',
    used_change_nickname_count    int(10)    default 0                 null comment '已使用修改昵称总次数',
    total_debinding_account_count int(10)    default 0                 null comment '解绑卡总数',
    used_debinding_account_count  int(10)    default 0                 null comment '已使用解绑卡数量',
    enable_create_chat_room       tinyint(2) default 0                 null comment '1-允许建群，0-不允许建群',
    bank_card                     varchar(32)                          null comment '银行卡号',
    bank_name                     varchar(32)                          null comment '银行名',
    bank_belong_path              varchar(128)                         null comment '开户行所在',
    bank_username                 varchar(32)                          null comment '银行卡所属人',
    trans_password                varchar(32)                          null comment '交易密码',
    remark                        varchar(255)                         null,
    is_band_cg                    tinyint(2) default 0                 not null comment '是否绑cg，0未绑',
    is_band_card                  tinyint(2) default 0                 not null comment '是否绑卡,0未绑',
    is_set_password               tinyint(2) default 0                 not null comment '是否设置支付密码，0未绑',
    exchange_status               tinyint(2) default -1                null comment '兑换状态',
    total_lottery_count           int(10)    default 0                 null comment '淘料发帖总数',
    lottery_win_count             int(10)    default 0                 null comment '淘料获胜次数',
    lottery_consecutive_count     int(10)    default 0                 null comment '连续获胜数',
    lottery_win_rate              int(10)    default 0                 null comment '胜率',
    article_count                 int(10)    default 0                 null comment '当月发帖数',
    create_time                   timestamp  default CURRENT_TIMESTAMP not null comment '创建时间',
    update_time                   timestamp  default CURRENT_TIMESTAMP not null on update CURRENT_TIMESTAMP comment '修改时间',
    lottery_user_id               bigint                               null comment '香港购彩用户ID',
    register_from                 varchar(256)                         null comment '注册来源',
    professional_status           tinyint(2) default 0                 null comment '六合彩专家状态，1-是，0-否',
    primary key (id)
)
    charset = utf8mb4;

create index index1
    on t_user_extend (ip);

create index index2
    on t_user_extend (status);

create index index3
    on t_user_extend (comment_status);

create index index4
    on t_user_extend (exchange_status);

create index index5
    on t_user_extend (publish);

create index index6
    on t_user_extend (professional_status);

create table if not exists t_user_level
(
    id            bigint                               not null comment 'ID作为等级值',
    activity_name varchar(255)                         null,
    description   varchar(2000)                        null,
    amount        decimal(10, 2)                       null,
    status        tinyint(2) default 1                 not null,
    award_status  tinyint(2) default 1                 not null,
    score         int(10)                              null comment '奖励成长值',
    name          varchar(200)                         null comment '等级名称',
    image_path    varchar(500)                         null comment '等级图标',
    create_time   timestamp  default CURRENT_TIMESTAMP not null comment '创建时间，默认为当前',
    update_time   timestamp  default CURRENT_TIMESTAMP not null on update CURRENT_TIMESTAMP comment '修改时间，默认为当前',
    primary key (id)
)
    comment '佣金' charset = utf8mb4;

create table if not exists t_user_level_reward
(
    id            bigint                               not null comment 'userLevelId + yyyyMM + userId作为主键',
    user_level_id bigint                               not null comment 'user_level_id',
    `key`         bigint                               not null comment 'yyyyMM+userId',
    amount        decimal(10, 2)                       null comment '奖金',
    reward        varchar(200)                         null comment '奖品',
    status        tinyint(2) default 1                 null,
    type          tinyint(2)                           null,
    user_id       bigint                               null comment '用户ID',
    user_level    int(2)                               null comment '获奖时用户等级',
    score         int(10)                              null comment '获奖时用户积分',
    create_time   timestamp  default CURRENT_TIMESTAMP not null comment '创建时间',
    update_time   timestamp  default CURRENT_TIMESTAMP not null comment '修改时间',
    primary key (id)
)
    charset = utf8mb4;

create index `key`
    on t_user_level_reward (`key`);

create table if not exists t_user_menu
(
    id      bigint auto_increment
        primary key,
    user_id bigint null comment '用户ID',
    menu_id bigint null comment '菜单的ID'
)
    charset = utf8mb4;

create table if not exists t_user_professional_article_stat
(
    id                                 bigint                             not null,
    user_id                            bigint                             not null,
    lottery_type                       tinyint(2)                         not null comment '彩种，1-香港，2-澳门，3-台湾',
    type                               tinyint(2)                         not null comment '类型，1-特肖，2-特码，3-单双，4-一肖，5-波色，6-连肖，7-杀特肖，8-一尾，9-大小，10-杀肖，11-杀特尾，12-杀尾',
    total_count                        int      default 0                 null comment '发贴总数',
    win_count                          int      default 0                 null comment '获胜次数',
    lose_count                         int      default 0                 null comment '失败次数',
    lottery_consecutive_count          int      default 0                 null comment '连续获胜次数',
    lottery_consecutive_lose_count     int      default 0                 null comment '连负次数',
    max_lottery_consecutive_count      int      default 0                 null comment '最大连续获胜次数',
    max_lottery_consecutive_lose_count int      default 0                 null comment '最大连续失败次数',
    latest_article_number              int      default 0                 null comment '最新发贴期数',
    latest_win_number                  int      default 0                 null comment '最新获胜期数',
    latest_lose_number                 int      default 0                 null comment '最新失败期数',
    lottery_win_rate                   int      default 0                 null comment '胜率',
    create_time                        datetime default CURRENT_TIMESTAMP not null comment '创建时间',
    update_time                        datetime                           null on update CURRENT_TIMESTAMP comment '修改时间',
    primary key (id),
    constraint index1
        unique (user_id, lottery_type, type)
)
    collate = utf8mb4_bin;

create index index2
    on t_user_professional_article_stat (user_id);

create table if not exists t_user_professional_article_stat_copy1_copy1
(
    id                                 bigint                             not null,
    user_id                            bigint                             not null,
    lottery_type                       tinyint(2)                         not null comment '彩种，1-香港，2-澳门，3-台湾',
    type                               tinyint(2)                         not null comment '类型，1-特肖，2-特码，3-单双，4-一肖，5-波色，6-连肖，7-杀特肖，8-一尾，9-大小，10-杀肖，11-杀特尾，12-杀尾',
    total_count                        int      default 0                 null comment '发贴总数',
    win_count                          int      default 0                 null comment '获胜次数',
    lose_count                         int      default 0                 null comment '失败次数',
    lottery_consecutive_count          int      default 0                 null comment '连续获胜次数',
    lottery_consecutive_lose_count     int      default 0                 null comment '连负次数',
    max_lottery_consecutive_count      int      default 0                 null comment '最大连续获胜次数',
    max_lottery_consecutive_lose_count int      default 0                 null comment '最大连续失败次数',
    latest_article_number              int      default 0                 null comment '最新发贴期数',
    latest_win_number                  int      default 0                 null comment '最新获胜期数',
    latest_lose_number                 int      default 0                 null comment '最新失败期数',
    lottery_win_rate                   int      default 0                 null comment '胜率',
    create_time                        datetime default CURRENT_TIMESTAMP not null comment '创建时间',
    update_time                        datetime                           null on update CURRENT_TIMESTAMP comment '修改时间',
    primary key (id),
    constraint index1
        unique (user_id, lottery_type, type)
)
    collate = utf8mb4_bin;

create index index2
    on t_user_professional_article_stat_copy1_copy1 (user_id);

create table if not exists t_user_recharge
(
    id                    bigint auto_increment
        primary key,
    user_id               bigint                                   not null comment '用户id',
    recharge_count        int            default 0                 null comment '充值次数',
    recharge_total_amount decimal(10, 2) default 0.00              null comment '总充值金额',
    recharge_max_amount   decimal(10, 2) default 0.00              null comment '最大充值金额',
    create_time           datetime       default CURRENT_TIMESTAMP not null comment '创建时间',
    update_time           datetime                                 null on update CURRENT_TIMESTAMP comment '修改时间'
)
    collate = utf8mb4_bin;

create table if not exists t_user_role
(
    id      bigint auto_increment comment '主键ID'
        primary key,
    user_id bigint null comment '用户ID',
    role_id bigint null comment '角色ID'
)
    charset = utf8mb4;

create table if not exists t_user_score_record
(
    id          varchar(40)                          not null comment 'type+user_id+related_id作为主键',
    user_id     bigint                               not null comment '用户ID',
    related_id  varchar(30)                          null comment '关联ID',
    type        tinyint(2) default 2                 null comment '类型(1-邀请，2-二级邀请，3-点赞，4-发帖，5-回帖)',
    vip         tinyint(2) default 0                 null comment '1-vip,0-非vip',
    status      tinyint(2) default 0                 not null comment '该奖励是否被领取',
    score       int(10)                              null comment '奖励成长值',
    create_time timestamp  default CURRENT_TIMESTAMP not null comment '创建时间，默认为当前',
    update_time timestamp  default CURRENT_TIMESTAMP not null on update CURRENT_TIMESTAMP comment '修改时间，默认为当前',
    primary key (id)
)
    comment '佣金' charset = utf8mb4;

create table if not exists t_user_score_standard
(
    id          bigint auto_increment comment '主键ID'
        primary key,
    name        varchar(200)                         null comment '名称',
    score       int(10)    default 0                 not null comment '奖励积分数',
    description varchar(1000)                        null comment '描述',
    limit_count int(10)                              null comment '每日限制次数',
    status      tinyint(2) default 1                 null,
    type        tinyint(2) default 1                 null,
    create_time timestamp  default CURRENT_TIMESTAMP not null comment '创建时间，默认为当前',
    update_time timestamp  default CURRENT_TIMESTAMP not null on update CURRENT_TIMESTAMP comment '修改时间，默认为当前'
)
    comment '佣金' charset = utf8mb4;

create table if not exists t_user_score_stat
(
    id          bigint                               not null comment '按天汇总，yyyyMMdd+userId作为主键,整体汇总，userId作为主键',
    user_id     bigint                               not null comment '用户ID',
    type        tinyint(2) default 1                 null comment '太长了，看UserScoreUtil吧',
    count       int(10)    default 0                 null comment '次数',
    score       int(10)    default 0                 null comment '积分',
    limit_count int(10)                              null comment '次数限制',
    create_time timestamp  default CURRENT_TIMESTAMP not null comment '创建时间，默认为当前',
    update_time timestamp  default CURRENT_TIMESTAMP not null on update CURRENT_TIMESTAMP comment '修改时间，默认为当前',
    primary key (id)
)
    comment '佣金' charset = utf8mb4;

create index type
    on t_user_score_stat (type, user_id);

create index user_id
    on t_user_score_stat (user_id, type);

create table if not exists t_user_score_sum
(
    id                     bigint                               not null comment '按天汇总，yyyyMMdd+userId作为主键,整体汇总，userId作为主键',
    user_id                bigint                               not null comment '用户ID',
    type                   tinyint(2) default 1                 null comment '1-单日汇总，2-整体汇总',
    invite_count           int(10)    default 0                 not null comment '邀请奖励次数',
    fill_invite_code_count int(10)    default 0                 null comment '补填邀请码次数',
    fill_invite_code_score int(10)    default 0                 null comment '补填邀请码积分',
    invite_score           int(10)    default 0                 null comment '邀请奖励积分',
    second_invite_count    int(10)    default 0                 null comment '二级邀请次数',
    second_invite_score    int(10)    default 0                 null comment '二级邀请奖励积分',
    thumb_up_count         int(10)    default 0                 null comment '点赞次数',
    thumb_up_score         int(10)    default 0                 null comment '点赞积分',
    post_count             int(10)    default 0                 null comment '发帖次数',
    post_score             int(10)    default 0                 null comment '发帖积分',
    reply_count            int(10)    default 0                 null comment '回帖次数',
    reply_score            int(10)    default 0                 null comment '回帖积分',
    create_time            timestamp  default CURRENT_TIMESTAMP not null comment '创建时间，默认为当前',
    update_time            timestamp  default CURRENT_TIMESTAMP not null on update CURRENT_TIMESTAMP comment '修改时间，默认为当前',
    primary key (id)
)
    comment '佣金' charset = utf8mb4;

create table if not exists t_user_stat_month
(
    id                     bigint                                   not null comment 'yyyyMM+user_id',
    user_id                bigint                                   null comment '用户ID',
    stat_date              int(10)                                  null comment '日期yyyyMM',
    invite_count           int            default 0                 null comment '邀请人数',
    effective_invite_count int            default 0                 null comment '有效邀请人数',
    income_amount          decimal(18, 2) default 0.00              null comment '总收入',
    expense_amount         decimal(18, 2) default 0.00              null comment '总支出',
    invite_reward_one      decimal(18, 2) default 0.00              null comment '一级拉新奖励',
    invite_reward_two      decimal(18, 2) default 0.00              null comment '二级拉新奖励',
    activity_reward        decimal(18, 2) default 0.00              null comment '活动奖励',
    create_time            timestamp      default CURRENT_TIMESTAMP null comment '创建时间',
    update_time            timestamp      default CURRENT_TIMESTAMP null comment '修改时间',
    primary key (id)
)
    charset = utf8mb4;

create index stat_date
    on t_user_stat_month (stat_date);

create index user_id
    on t_user_stat_month (user_id, stat_date);

create table if not exists t_user_try_login_stat_day
(
    id          bigint                             not null,
    user_id     bigint                             not null,
    try_count   int      default 0                 null,
    create_time datetime default CURRENT_TIMESTAMP not null,
    update_time datetime                           null on update CURRENT_TIMESTAMP,
    primary key (id)
)
    collate = utf8mb4_bin;

create table if not exists t_user_vip_record
(
    id          bigint auto_increment comment '自增主键'
        primary key,
    user_id     bigint                               not null comment '用户ID',
    order_no    varchar(30)                          null comment '订单号',
    type        tinyint(2) default 2                 null comment '类型（1-月度，2-年度）',
    status      tinyint(2) default 0                 not null comment '1-有效，0-无效',
    amount      decimal(10, 2)                       null comment '金额',
    pay_type    tinyint(2)                           null comment '1-付费，0-赠送',
    count       int(10)                              null comment '数量',
    end_time    timestamp                            null comment '本次购买到期时间',
    create_time timestamp  default CURRENT_TIMESTAMP not null comment '创建时间，默认为当前',
    update_time timestamp  default CURRENT_TIMESTAMP not null on update CURRENT_TIMESTAMP comment '修改时间，默认为当前'
)
    comment '佣金' charset = utf8mb4;

create table if not exists t_vote
(
    id           bigint                                not null comment 'type+year + period 作为主键ID',
    lottery_type tinyint(10) default 2                 null comment '1-香港，2-澳门，3-台湾',
    year         int(4)                                null,
    period int (3) null,
    animal_1     int(10)     default 0                 null,
    animal_2     int(10)     default 0                 null,
    animal_3     int(10)     default 0                 null,
    animal_4     int(10)     default 0                 null,
    animal_5     int(10)     default 0                 null,
    animal_6     int(10)     default 0                 null,
    animal_7     int(10)     default 0                 null,
    animal_8     int(10)     default 0                 null,
    animal_9     int(10)     default 0                 null,
    animal_10    int(10)     default 0                 null,
    animal_11    int(10)     default 0                 null,
    animal_12    int(10)     default 0                 null,
    type         tinyint(2)  default 1                 not null comment ' 1-六合图库，2-幽默竞猜',
    status       tinyint(2)  default 1                 not null,
    create_time  timestamp   default CURRENT_TIMESTAMP not null comment '创建时间，默认为当前',
    update_time  timestamp   default CURRENT_TIMESTAMP not null on update CURRENT_TIMESTAMP comment '修改时间，默认为当前',
    primary key (id)
)
    comment '佣金' charset = utf8mb4;

create table if not exists t_vote_record
(
    id          bigint                               not null comment 'year + period+user_id 作为主键ID',
    year        int(4)                               null,
    period int (3) null,
    vote_id     bigint                               null,
    user_id     bigint                               null,
    animal      int(2)                               null,
    type        tinyint(2) default 2                 null,
    status      tinyint(2) default 0                 not null comment '该奖励是否被领取',
    create_time timestamp  default CURRENT_TIMESTAMP not null comment '创建时间，默认为当前',
    update_time timestamp  default CURRENT_TIMESTAMP not null on update CURRENT_TIMESTAMP comment '修改时间，默认为当前',
    primary key (id)
)
    comment '佣金' charset = utf8mb4;

create table if not exists t_withdraw
(
    id                   bigint auto_increment comment 'ID，自增长'
        primary key,
    user_id              bigint                               not null comment '成员ID',
    account_id           bigint                               not null comment '账户ID',
    amount               decimal(18, 2)                       not null comment '金额',
    fee_rate             decimal(10, 4)                       null comment '手续费率',
    fee_amount           decimal(18, 2)                       null comment '提现手续费',
    valid_amount         decimal(18, 2)                       null comment '有效打码量',
    required_amount      decimal(18, 2)                       null comment '最低要求打码量',
    trade_no             varchar(32)                          null comment '兑换平台流水号',
    order_no             varchar(128)                         null comment '订单号',
    exchange_account     varchar(255)                         null comment '兑换的平台账号',
    platform             varchar(32)                          null comment '兑换的平台名称',
    sys_id               bigint                               null comment '咱们自己系统人员的客服ID',
    verify_status        tinyint    default 1                 not null comment '审核状态(1:审核中;2:审核完成;3-待平台确认)',
    verify_result_status tinyint                              null comment '审核结果的状态(1:不通过;2:通过)',
    verify_result        varchar(128)                         null comment '审核通过或是不通过的原因',
    reach_time           timestamp  default CURRENT_TIMESTAMP not null on update CURRENT_TIMESTAMP comment '到账的时间',
    reach_status         tinyint    default 0                 null comment '到账的状态(0:通知; 1:已通知;  2-已到账; 3-被拒绝；-1失败)',
    retry_count          int(4)     default 0                 not null comment '重试次数',
    type                 tinyint                              null comment '操作类型(9:提现;10:兑换)',
    bank_card            varchar(32)                          null comment '银行卡号',
    bank_name            varchar(32)                          null comment '银行名',
    bank_username        varchar(32)                          null comment '银行卡所属人',
    bank_belong_path     varchar(64)                          null comment '开户行所在',
    remark               varchar(128)                         null comment '备注',
    transfer_img         varchar(256)                         null comment '转账的凭证',
    status               tinyint    default 1                 not null comment '状态 1为有效 0为无效 默认为1',
    operation_user_id    bigint                               null comment '操作人id',
    is_lock              tinyint(2) default 0                 not null,
    start_time           timestamp                            null comment '开始统计时间',
    create_time          timestamp  default CURRENT_TIMESTAMP not null comment '创建时间，默认为当前',
    update_time          timestamp  default CURRENT_TIMESTAMP not null on update CURRENT_TIMESTAMP comment '修改时间，默认为当前',
    constraint order_no
        unique (order_no)
)
    comment '提现' charset = utf8mb4;

create index INDEX_VERIFY_STATUS
    on t_withdraw (verify_status);


insert into lhtk.t_account (id, user_id, type, balance_income_amount, balance_expense_amount, available_balance, money_balance, balance_money_income_amount, balance_money_expense_amount, brokerage_income_amount, brokerage_expense_amount, withdraw_count, total_withdraw_amount, total_exchange_amount, available_brokerage, freeze_balance_amount, freeze_money_amount, freeze_brokerage_amount, settlement_type, total_score, available_score, recharge_count, total_recharge_amount, max_recharge_amount, recharge_company_bank_amount, recharge_on_line_amount, recharge_by_manual_amount, recharge_by_exchange_amount, last_recharge_time, total_promote_amount, sync_status, status, create_time, update_time)
values  (1, 1, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2022-11-12 06:38:50', '2022-11-12 06:38:50'),
        (2, 2, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2022-11-12 08:13:54', '2022-11-12 08:13:54'),
        (3, 3, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-08-23 16:40:17', '2023-08-23 04:55:50'),
        (4, 4, 1, 16.00, 16.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2022-12-03 12:27:13', '2023-08-30 04:52:49'),
        (5, 5, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2022-12-30 11:41:06', '2022-12-30 11:41:15'),
        (6, 6, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-01-10 17:17:51', '2023-01-10 17:17:30'),
        (7, 7, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-01-10 18:55:12', '2023-01-10 18:54:51'),
        (10, 10, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-01-31 15:34:22', '2023-01-31 15:35:02'),
        (11, 11, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-01-31 15:34:59', '2023-01-31 15:35:39'),
        (13, 13, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-01-31 15:36:17', '2023-01-31 15:36:57'),
        (15, 15, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-01-31 15:37:34', '2023-01-31 15:38:14'),
        (17, 17, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-01-31 15:38:23', '2023-01-31 15:39:04'),
        (18, 18, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-01-31 16:17:06', '2023-01-31 16:17:40'),
        (19, 19, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-01-31 16:23:51', '2023-01-31 16:24:25'),
        (20, 20, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-02-09 19:46:20', '2023-02-09 11:46:20'),
        (21, 21, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-02-10 13:06:42', '2023-02-10 05:06:41'),
        (22, 22, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-02-14 11:29:20', '2023-02-14 03:29:20'),
        (23, 23, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-02-14 15:52:13', '2023-02-14 07:52:12'),
        (24, 24, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-08-23 16:40:17', '2023-08-23 04:55:50'),
        (25, 25, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-02-21 20:06:24', '2023-02-21 12:06:23'),
        (26, 26, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-08-23 16:40:16', '2023-08-23 04:55:49'),
        (27, 27, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-08-23 16:40:16', '2023-08-23 04:55:49'),
        (30, 30, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-02-22 19:54:28', '2023-02-22 11:54:28'),
        (31, 31, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-02-22 19:57:45', '2023-02-22 11:57:45'),
        (33, 33, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-02-22 19:59:57', '2023-02-22 11:59:57'),
        (35, 35, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-02-22 20:07:31', '2023-02-22 12:07:31'),
        (37, 37, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-02-22 20:11:20', '2023-02-22 12:11:20'),
        (40, 40, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-02-22 20:26:32', '2023-02-22 12:26:32'),
        (41, 41, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-02-22 20:34:59', '2023-02-22 12:34:58'),
        (43, 43, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-02-22 20:43:09', '2023-02-22 12:43:08'),
        (45, 45, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-02-22 20:45:23', '2023-02-22 12:45:22'),
        (47, 47, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-02-22 20:51:37', '2023-02-22 12:51:37'),
        (50, 50, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-02-22 20:56:07', '2023-02-22 12:56:07'),
        (51, 51, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-02-22 20:57:13', '2023-02-22 12:57:13'),
        (52, 52, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-02-22 20:57:50', '2023-02-22 12:57:50'),
        (53, 53, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-02-22 20:58:42', '2023-02-22 12:58:41'),
        (54, 54, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-02-22 20:59:23', '2023-02-22 12:59:23'),
        (55, 55, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-02-22 21:00:11', '2023-02-22 13:00:11'),
        (56, 56, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-02-22 21:01:16', '2023-02-22 13:01:15'),
        (57, 57, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-02-22 21:02:02', '2023-02-22 13:02:02'),
        (58, 58, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-02-22 21:02:44', '2023-02-22 13:02:43'),
        (59, 59, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-02-22 21:03:19', '2023-02-22 13:03:19'),
        (60, 60, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-02-22 21:04:25', '2023-02-22 13:04:24'),
        (61, 61, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-02-22 21:05:05', '2023-02-22 13:05:04'),
        (62, 62, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-02-22 21:05:45', '2023-02-22 13:05:45'),
        (63, 63, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-02-22 21:06:32', '2023-02-22 13:06:31'),
        (64, 64, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-02-22 21:08:28', '2023-02-22 13:08:27'),
        (65, 65, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-02-22 21:09:09', '2023-02-22 13:09:08'),
        (66, 66, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-02-22 21:09:52', '2023-02-22 13:09:51'),
        (67, 67, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-02-22 21:13:39', '2023-02-22 13:13:38'),
        (68, 68, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-02-22 21:14:50', '2023-02-22 13:14:50'),
        (69, 69, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-02-22 21:15:28', '2023-02-22 13:15:28'),
        (70, 70, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-02-22 21:16:03', '2023-02-22 13:16:03'),
        (71, 71, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-02-22 21:16:41', '2023-02-22 13:16:40'),
        (72, 72, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-02-22 21:17:21', '2023-02-22 13:17:21'),
        (73, 73, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-02-22 21:17:56', '2023-02-22 13:17:56'),
        (74, 74, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-02-22 21:19:15', '2023-02-22 13:19:15'),
        (75, 75, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-02-22 21:20:04', '2023-02-22 13:20:03'),
        (76, 76, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-02-22 21:20:45', '2023-02-22 13:20:44'),
        (77, 77, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-02-22 21:22:30', '2023-02-22 13:22:29'),
        (78, 78, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-02-22 21:23:12', '2023-02-22 13:23:11'),
        (79, 79, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-02-22 21:23:49', '2023-02-22 13:23:48'),
        (80, 80, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-02-22 21:24:31', '2023-02-22 13:24:31'),
        (81, 81, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-02-22 21:25:05', '2023-02-22 13:25:05'),
        (82, 82, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-02-22 22:04:50', '2023-02-22 14:04:49'),
        (83, 83, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-02-22 22:06:36', '2023-02-22 14:06:35'),
        (84, 84, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-02-22 22:07:05', '2023-02-22 14:07:04'),
        (85, 85, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-02-22 22:07:53', '2023-02-22 14:07:53'),
        (86, 86, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-02-22 22:08:26', '2023-02-22 14:08:25'),
        (87, 87, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-02-23 16:53:07', '2023-02-23 08:53:07'),
        (88, 88, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-02-23 22:18:22', '2023-02-23 14:18:22'),
        (89, 89, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-02-23 22:21:52', '2023-02-23 14:21:51'),
        (90, 90, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-02-23 22:25:04', '2023-02-23 14:25:04'),
        (91, 91, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-02-23 22:26:25', '2023-02-23 14:26:24'),
        (92, 92, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-02-23 22:28:13', '2023-02-23 14:28:12'),
        (93, 93, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-02-23 22:29:49', '2023-02-23 14:29:48'),
        (94, 94, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-02-23 22:31:09', '2023-02-23 14:31:09'),
        (95, 95, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-02-23 22:32:08', '2023-02-23 14:32:08'),
        (96, 96, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-02-24 10:50:55', '2023-02-24 02:50:54'),
        (97, 97, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-02-24 10:52:30', '2023-02-24 02:52:29'),
        (98, 98, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-02-24 10:54:07', '2023-02-24 02:54:07'),
        (99, 99, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-02-24 10:55:51', '2023-02-24 02:55:51'),
        (100, 100, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-02-24 10:57:25', '2023-02-24 02:57:25'),
        (101, 101, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-02-24 10:58:30', '2023-02-24 02:58:30'),
        (102, 102, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-02-24 11:00:55', '2023-02-24 03:00:54'),
        (103, 103, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-02-24 11:02:56', '2023-02-24 03:02:55'),
        (104, 104, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-02-24 11:04:19', '2023-02-24 03:04:19'),
        (105, 105, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-02-24 11:05:39', '2023-02-24 03:05:38'),
        (106, 106, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-02-24 11:07:59', '2023-02-24 03:07:58'),
        (107, 107, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-02-24 11:09:36', '2023-02-24 03:09:36'),
        (108, 108, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-02-24 11:10:55', '2023-02-24 03:10:54'),
        (109, 109, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-02-24 11:12:09', '2023-02-24 03:12:08'),
        (120, 120, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-02-24 13:15:15', '2023-02-24 05:15:15'),
        (121, 121, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-02-24 13:16:28', '2023-02-24 05:16:27'),
        (122, 122, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-02-24 13:17:37', '2023-02-24 05:17:36'),
        (123, 123, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-02-24 13:19:04', '2023-02-24 05:19:04'),
        (124, 124, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-02-24 13:20:18', '2023-02-24 05:20:17'),
        (126, 126, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-02-24 13:25:07', '2023-02-24 05:25:07'),
        (127, 127, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-02-24 13:28:24', '2023-02-24 05:28:23'),
        (168, 168, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-08-23 16:40:16', '2023-08-23 04:55:49'),
        (200, 200, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-02-24 16:42:08', '2023-02-24 08:42:08'),
        (201, 201, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-02-24 16:43:09', '2023-02-24 08:43:09'),
        (202, 202, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-02-24 16:47:07', '2023-02-24 08:47:07'),
        (203, 203, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-02-24 16:48:33', '2023-02-24 08:48:33'),
        (204, 204, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-02-24 17:22:55', '2023-02-24 09:22:54'),
        (205, 205, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-02-24 17:24:38', '2023-02-24 09:24:37'),
        (206, 206, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-02-24 17:26:00', '2023-02-24 09:25:59'),
        (207, 207, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-02-24 17:27:23', '2023-02-24 09:27:23'),
        (208, 208, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-02-24 17:28:21', '2023-02-24 09:28:21'),
        (209, 209, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-02-24 17:29:15', '2023-02-24 09:29:14'),
        (220, 220, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-02-24 17:41:06', '2023-02-24 09:41:06'),
        (221, 221, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-02-24 17:42:09', '2023-02-24 09:42:08'),
        (222, 222, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-02-24 17:43:21', '2023-02-24 09:43:20'),
        (223, 223, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-02-24 20:15:36', '2023-02-24 12:15:36'),
        (224, 224, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-02-24 20:20:09', '2023-02-24 12:20:08'),
        (226, 226, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-02-24 20:22:19', '2023-02-24 12:22:18'),
        (227, 227, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-02-24 20:24:38', '2023-02-24 12:24:38'),
        (300, 300, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-02-24 21:20:31', '2023-02-24 13:20:31'),
        (301, 301, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-02-24 21:20:35', '2023-02-24 13:20:35'),
        (302, 302, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-02-24 21:20:58', '2023-02-24 13:20:58'),
        (303, 303, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-02-24 21:21:07', '2023-02-24 13:21:06'),
        (304, 304, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-02-24 21:21:20', '2023-02-24 13:21:19'),
        (305, 305, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-02-24 21:21:32', '2023-02-24 13:21:32'),
        (306, 306, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-02-24 21:21:47', '2023-02-24 13:21:46'),
        (307, 307, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-02-24 21:22:11', '2023-02-24 13:22:10'),
        (308, 308, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-02-24 21:22:14', '2023-02-24 13:22:13'),
        (309, 309, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-02-24 21:22:39', '2023-02-24 13:22:39'),
        (313, 313, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-02-26 11:06:55', '2023-02-26 03:06:55'),
        (314, 314, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-02-26 11:08:30', '2023-02-26 03:08:29'),
        (315, 315, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-02-26 11:09:28', '2023-02-26 03:09:28'),
        (316, 316, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-02-26 11:12:38', '2023-02-26 03:12:38'),
        (317, 317, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-02-26 11:14:46', '2023-02-26 03:14:46'),
        (318, 318, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-02-26 11:17:25', '2023-02-26 03:17:25'),
        (319, 319, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-02-26 11:20:06', '2023-02-26 03:20:06'),
        (320, 320, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-02-26 11:20:55', '2023-02-26 03:20:55'),
        (321, 321, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-02-26 11:23:30', '2023-02-26 03:23:30'),
        (322, 322, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-02-26 11:27:07', '2023-02-26 03:27:07'),
        (323, 323, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-02-26 11:29:25', '2023-02-26 03:29:25'),
        (324, 324, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-02-26 11:31:05', '2023-02-26 03:31:05'),
        (325, 325, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-02-26 11:33:36', '2023-02-26 03:33:36'),
        (326, 326, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-02-26 11:36:06', '2023-02-26 03:36:06'),
        (327, 327, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-02-26 11:36:52', '2023-02-26 03:36:51'),
        (328, 328, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-02-26 11:38:07', '2023-02-26 03:38:06'),
        (329, 329, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-02-26 11:38:43', '2023-02-26 03:38:43'),
        (330, 330, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-02-26 11:40:41', '2023-02-26 03:40:40'),
        (331, 331, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-02-26 11:43:33', '2023-02-26 03:43:32'),
        (332, 332, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-02-26 11:46:13', '2023-02-26 03:46:13'),
        (333, 333, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-02-26 11:47:14', '2023-02-26 03:47:13'),
        (334, 334, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-02-26 11:47:37', '2023-02-26 03:47:37'),
        (335, 335, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-02-26 11:48:28', '2023-02-26 03:48:28'),
        (336, 336, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-02-26 11:49:29', '2023-02-26 03:49:29'),
        (337, 337, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-02-26 11:50:04', '2023-02-26 03:50:04'),
        (338, 338, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-02-26 11:50:49', '2023-02-26 03:50:49'),
        (339, 339, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-02-26 11:56:45', '2023-02-26 03:56:44'),
        (340, 340, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-02-26 11:57:29', '2023-02-26 03:57:28'),
        (341, 341, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-02-26 11:59:11', '2023-02-26 03:59:10'),
        (342, 342, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-02-26 12:00:30', '2023-02-26 04:00:30'),
        (343, 343, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-02-26 12:01:45', '2023-02-26 04:01:45'),
        (344, 344, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-02-26 12:02:06', '2023-02-26 04:02:05'),
        (345, 345, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-02-26 12:02:31', '2023-02-26 04:02:31'),
        (346, 346, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-02-26 12:03:16', '2023-02-26 04:03:15'),
        (347, 347, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-02-26 12:18:34', '2023-02-26 04:18:34'),
        (348, 348, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-02-26 12:20:05', '2023-02-26 04:20:05'),
        (349, 349, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-02-26 12:34:37', '2023-02-26 04:34:36'),
        (350, 350, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-02-26 12:34:57', '2023-02-26 04:34:57'),
        (351, 351, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-02-26 12:35:06', '2023-02-26 04:35:06'),
        (352, 352, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-02-26 12:35:36', '2023-02-26 04:35:36'),
        (353, 353, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-02-26 12:36:03', '2023-02-26 04:36:03'),
        (354, 354, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-02-26 12:36:10', '2023-02-26 04:36:09'),
        (355, 355, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-02-26 12:36:37', '2023-02-26 04:36:37'),
        (356, 356, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-02-26 12:37:04', '2023-02-26 04:37:04'),
        (357, 357, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-02-26 12:37:44', '2023-02-26 04:37:43'),
        (358, 358, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-02-26 12:38:24', '2023-02-26 04:38:24'),
        (359, 359, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-02-26 12:38:40', '2023-02-26 04:38:40'),
        (360, 360, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-02-26 12:38:57', '2023-02-26 04:38:56'),
        (361, 361, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-02-26 12:39:06', '2023-02-26 04:39:06'),
        (362, 362, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-02-26 12:41:04', '2023-02-26 04:41:03'),
        (363, 363, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-02-26 12:41:56', '2023-02-26 04:41:55'),
        (364, 364, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-02-26 12:42:17', '2023-02-26 04:42:16'),
        (365, 365, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-02-26 12:42:47', '2023-02-26 04:42:47'),
        (366, 366, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-02-26 12:42:55', '2023-02-26 04:42:55'),
        (367, 367, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-02-26 12:43:08', '2023-02-26 04:43:07'),
        (368, 368, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-02-26 12:43:26', '2023-02-26 04:43:26'),
        (369, 369, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-02-26 12:43:37', '2023-02-26 04:43:37'),
        (370, 370, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-02-26 12:44:13', '2023-02-26 04:44:13'),
        (371, 371, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-02-26 12:44:36', '2023-02-26 04:44:35'),
        (372, 372, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-02-26 12:44:55', '2023-02-26 04:44:55'),
        (373, 373, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-02-26 12:45:08', '2023-02-26 04:45:08'),
        (374, 374, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-02-26 12:45:41', '2023-02-26 04:45:40'),
        (375, 375, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-02-26 12:47:13', '2023-02-26 04:47:13'),
        (376, 376, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-02-26 12:47:40', '2023-02-26 04:47:39'),
        (377, 377, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-02-26 12:48:01', '2023-02-26 04:48:01'),
        (378, 378, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-02-26 12:48:24', '2023-02-26 04:48:23'),
        (379, 379, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-02-26 12:48:46', '2023-02-26 04:48:46'),
        (380, 380, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-02-26 12:49:11', '2023-02-26 04:49:10'),
        (381, 381, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-02-26 12:49:27', '2023-02-26 04:49:26'),
        (382, 382, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-02-26 12:49:32', '2023-02-26 04:49:32'),
        (383, 383, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-02-26 12:52:39', '2023-02-26 04:52:38'),
        (384, 384, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-02-26 12:52:52', '2023-02-26 04:52:52'),
        (385, 385, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-02-26 12:52:59', '2023-02-26 04:52:59'),
        (386, 386, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-02-26 12:54:10', '2023-02-26 04:54:10'),
        (387, 387, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-02-26 12:55:23', '2023-02-26 04:55:22'),
        (388, 388, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-02-26 12:55:31', '2023-02-26 04:55:31'),
        (389, 389, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-02-26 12:55:48', '2023-02-26 04:55:47'),
        (390, 390, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-02-26 12:56:12', '2023-02-26 04:56:12'),
        (391, 391, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-02-26 12:56:28', '2023-02-26 04:56:27'),
        (392, 392, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-02-26 12:56:49', '2023-02-26 04:56:48'),
        (393, 393, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-02-26 12:57:08', '2023-02-26 04:57:08'),
        (394, 394, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-02-26 12:57:34', '2023-02-26 04:57:34'),
        (395, 395, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-02-26 12:58:04', '2023-02-26 04:58:03'),
        (396, 396, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-02-26 12:58:31', '2023-02-26 04:58:31'),
        (397, 397, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-02-26 12:58:35', '2023-02-26 04:58:35'),
        (398, 398, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-02-26 12:58:59', '2023-02-26 04:58:58'),
        (399, 399, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-02-26 12:59:37', '2023-02-26 04:59:37'),
        (400, 400, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-02-26 13:01:33', '2023-02-26 05:01:33'),
        (401, 401, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-02-26 13:02:28', '2023-02-26 05:02:28'),
        (402, 402, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-02-26 13:03:53', '2023-02-26 05:03:52'),
        (403, 403, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-02-26 13:04:30', '2023-02-26 05:04:29'),
        (404, 404, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-02-26 13:04:54', '2023-02-26 05:04:53'),
        (405, 405, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-02-26 13:05:44', '2023-02-26 05:05:44'),
        (406, 406, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-02-26 13:06:07', '2023-02-26 05:06:07'),
        (407, 407, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-02-26 13:06:22', '2023-02-26 05:06:22'),
        (408, 408, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-02-26 13:06:24', '2023-02-26 05:06:23'),
        (409, 409, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-02-26 13:07:05', '2023-02-26 05:07:05'),
        (410, 410, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-02-26 13:07:15', '2023-02-26 05:07:14'),
        (411, 411, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-02-26 13:07:35', '2023-02-26 05:07:35'),
        (412, 412, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-02-26 13:07:46', '2023-02-26 05:07:45'),
        (413, 413, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-02-26 13:07:48', '2023-02-26 05:07:47'),
        (414, 414, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-02-26 13:08:05', '2023-02-26 05:08:04'),
        (415, 415, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-02-26 13:08:34', '2023-02-26 05:08:34'),
        (416, 416, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-02-26 13:08:55', '2023-02-26 05:08:54'),
        (417, 417, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-02-26 13:08:57', '2023-02-26 05:08:56'),
        (418, 418, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-02-26 13:09:01', '2023-02-26 05:09:01'),
        (419, 419, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-02-26 13:09:16', '2023-02-26 05:09:15'),
        (420, 420, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-02-26 13:09:36', '2023-02-26 05:09:36'),
        (421, 421, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-02-26 13:09:56', '2023-02-26 05:09:56'),
        (422, 422, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-02-26 13:10:06', '2023-02-26 05:10:06'),
        (423, 423, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-02-26 13:10:16', '2023-02-26 05:10:16'),
        (424, 424, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-02-26 13:10:32', '2023-02-26 05:10:31'),
        (425, 425, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-02-26 13:10:51', '2023-02-26 05:10:51'),
        (426, 426, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-02-26 13:11:05', '2023-02-26 05:11:05'),
        (427, 427, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-02-26 13:11:07', '2023-02-26 05:11:06'),
        (428, 428, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-02-26 13:11:26', '2023-02-26 05:11:26'),
        (429, 429, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-02-26 13:11:30', '2023-02-26 05:11:30'),
        (430, 430, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-02-26 13:11:45', '2023-02-26 05:11:45'),
        (431, 431, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-02-26 13:11:52', '2023-02-26 05:11:52'),
        (432, 432, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-02-26 13:11:58', '2023-02-26 05:11:58'),
        (433, 433, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-02-26 13:12:06', '2023-02-26 05:12:06'),
        (434, 434, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-02-26 13:12:24', '2023-02-26 05:12:24'),
        (435, 435, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-02-26 13:12:27', '2023-02-26 05:12:27'),
        (436, 436, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-02-26 13:12:28', '2023-02-26 05:12:27'),
        (437, 437, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-02-26 13:12:49', '2023-02-26 05:12:49'),
        (438, 438, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-02-26 13:12:58', '2023-02-26 05:12:57'),
        (439, 439, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-02-26 13:13:07', '2023-02-26 05:13:07'),
        (440, 440, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-02-26 13:13:08', '2023-02-26 05:13:07'),
        (441, 441, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-02-26 13:13:22', '2023-02-26 05:13:22'),
        (442, 442, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-02-26 13:13:35', '2023-02-26 05:13:35'),
        (443, 443, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-02-26 13:13:55', '2023-02-26 05:13:55'),
        (444, 444, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-02-26 13:13:56', '2023-02-26 05:13:55'),
        (445, 445, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-02-26 13:14:17', '2023-02-26 05:14:16'),
        (446, 446, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-02-26 13:14:37', '2023-02-26 05:14:37'),
        (447, 447, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-02-26 13:14:42', '2023-02-26 05:14:42'),
        (448, 448, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-02-26 13:15:02', '2023-02-26 05:15:02'),
        (449, 449, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-02-26 13:15:15', '2023-02-26 05:15:14'),
        (450, 450, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-02-26 13:15:21', '2023-02-26 05:15:20'),
        (451, 451, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-02-26 13:15:37', '2023-02-26 05:15:37'),
        (452, 452, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-02-26 13:15:57', '2023-02-26 05:15:57'),
        (453, 453, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-02-26 13:16:05', '2023-02-26 05:16:04'),
        (454, 454, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-02-26 13:16:18', '2023-02-26 05:16:17'),
        (455, 455, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-02-26 13:16:39', '2023-02-26 05:16:38'),
        (456, 456, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-02-26 13:17:03', '2023-02-26 05:17:02'),
        (457, 457, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-02-26 13:17:06', '2023-02-26 05:17:05'),
        (458, 458, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-02-26 13:17:23', '2023-02-26 05:17:22'),
        (459, 459, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-02-26 13:17:36', '2023-02-26 05:17:35'),
        (460, 460, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-02-26 13:18:01', '2023-02-26 05:18:01'),
        (461, 461, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-02-26 13:18:03', '2023-02-26 05:18:02'),
        (462, 462, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-02-26 13:18:21', '2023-02-26 05:18:20'),
        (463, 463, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-02-26 13:18:37', '2023-02-26 05:18:37'),
        (464, 464, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-02-26 13:18:39', '2023-02-26 05:18:38'),
        (465, 465, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-02-26 13:18:56', '2023-02-26 05:18:56'),
        (466, 466, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-02-26 13:19:13', '2023-02-26 05:19:13'),
        (467, 467, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-02-26 13:19:33', '2023-02-26 05:19:32'),
        (468, 468, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-02-26 13:19:55', '2023-02-26 05:19:55'),
        (469, 469, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-02-26 13:20:15', '2023-02-26 05:20:14'),
        (470, 470, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-02-26 13:20:33', '2023-02-26 05:20:32'),
        (471, 471, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-02-26 13:20:55', '2023-02-26 05:20:54'),
        (472, 472, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-02-26 13:21:16', '2023-02-26 05:21:16'),
        (473, 473, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-02-26 13:21:34', '2023-02-26 05:21:33'),
        (474, 474, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-02-26 13:22:11', '2023-02-26 05:22:11'),
        (475, 475, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-02-26 13:22:35', '2023-02-26 05:22:34'),
        (476, 476, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-02-26 13:22:51', '2023-02-26 05:22:51'),
        (477, 477, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-02-26 13:23:11', '2023-02-26 05:23:11'),
        (478, 478, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-02-26 13:23:27', '2023-02-26 05:23:26'),
        (479, 479, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-02-26 13:23:43', '2023-02-26 05:23:43'),
        (480, 480, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-02-26 13:24:00', '2023-02-26 05:24:00'),
        (481, 481, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-02-26 13:24:47', '2023-02-26 05:24:47'),
        (482, 482, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-02-26 13:25:05', '2023-02-26 05:25:04'),
        (483, 483, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-02-26 13:25:27', '2023-02-26 05:25:26'),
        (484, 484, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-02-26 13:25:45', '2023-02-26 05:25:45'),
        (485, 485, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-02-26 13:26:14', '2023-02-26 05:26:13'),
        (486, 486, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-02-26 13:26:22', '2023-02-26 05:26:21'),
        (487, 487, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-02-26 13:26:35', '2023-02-26 05:26:35'),
        (488, 488, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-02-26 13:26:46', '2023-02-26 05:26:46'),
        (489, 489, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-02-26 13:26:54', '2023-02-26 05:26:54'),
        (490, 490, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-02-26 13:27:15', '2023-02-26 05:27:15'),
        (491, 491, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-02-26 13:27:26', '2023-02-26 05:27:25'),
        (492, 492, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-02-26 13:27:34', '2023-02-26 05:27:33'),
        (493, 493, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-02-26 13:27:54', '2023-02-26 05:27:53'),
        (494, 494, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-02-26 13:28:01', '2023-02-26 05:28:00'),
        (495, 495, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-02-26 13:28:17', '2023-02-26 05:28:17'),
        (496, 496, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-02-26 13:28:26', '2023-02-26 05:28:25'),
        (497, 497, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-02-26 13:28:37', '2023-02-26 05:28:37'),
        (498, 498, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-02-27 13:01:31', '2023-02-27 05:01:31'),
        (499, 499, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-02-28 11:25:59', '2023-02-28 03:25:59'),
        (500, 500, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-02-28 11:26:42', '2023-02-28 03:26:41'),
        (501, 501, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-02-28 11:27:33', '2023-02-28 03:27:33'),
        (502, 502, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-02-28 11:31:00', '2023-02-28 03:31:00'),
        (503, 503, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-02-28 11:32:14', '2023-02-28 03:32:14'),
        (504, 504, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-02-28 11:33:13', '2023-02-28 03:33:13'),
        (505, 505, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-02-28 11:34:11', '2023-02-28 03:34:11'),
        (506, 506, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-02-28 11:35:23', '2023-02-28 03:35:22'),
        (507, 507, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-02-28 11:35:59', '2023-02-28 03:35:59'),
        (508, 508, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-02-28 11:36:45', '2023-02-28 03:36:45'),
        (509, 509, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-02-28 11:45:14', '2023-02-28 03:45:14'),
        (510, 510, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-02-28 11:47:14', '2023-02-28 03:47:13'),
        (511, 511, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-02-28 11:49:34', '2023-02-28 03:49:33'),
        (512, 512, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-02-28 18:05:34', '2023-02-28 10:05:33'),
        (513, 513, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-02-28 18:12:06', '2023-02-28 10:12:05'),
        (514, 514, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-02-28 18:14:59', '2023-02-28 10:14:58'),
        (515, 515, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-02-28 18:15:42', '2023-02-28 10:15:42'),
        (516, 516, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-02-28 18:15:43', '2023-02-28 10:15:42'),
        (517, 517, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-02-28 18:16:11', '2023-02-28 10:16:11'),
        (518, 518, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-02-28 18:17:20', '2023-02-28 10:17:19'),
        (519, 519, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-02-28 18:17:47', '2023-02-28 10:17:47'),
        (520, 520, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-02-28 18:17:55', '2023-02-28 10:17:55'),
        (521, 521, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-02-28 18:18:15', '2023-02-28 10:18:15'),
        (522, 522, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-02-28 18:21:47', '2023-02-28 10:21:47'),
        (523, 523, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-02-28 18:23:43', '2023-02-28 10:23:43'),
        (524, 524, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-02-28 18:29:21', '2023-02-28 10:29:20'),
        (525, 525, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-02-28 18:30:11', '2023-02-28 10:30:11'),
        (526, 526, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-02-28 18:30:37', '2023-02-28 10:30:36'),
        (527, 527, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-02-28 18:31:22', '2023-02-28 10:31:21'),
        (528, 528, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-02-28 18:32:07', '2023-02-28 10:32:07'),
        (529, 529, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-02-28 18:37:21', '2023-02-28 10:37:20'),
        (530, 530, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-02-28 18:37:50', '2023-02-28 10:37:50'),
        (531, 531, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-02-28 18:59:23', '2023-02-28 10:59:22'),
        (532, 532, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-02-28 19:00:41', '2023-02-28 11:00:40'),
        (533, 533, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-02-28 19:01:17', '2023-02-28 11:01:16'),
        (534, 534, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-02-28 19:02:17', '2023-02-28 11:02:16'),
        (535, 535, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-02-28 19:03:15', '2023-02-28 11:03:14'),
        (536, 536, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-02-28 19:55:11', '2023-02-28 11:55:11'),
        (537, 537, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-02-28 19:55:44', '2023-02-28 11:55:44'),
        (538, 538, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-02-28 19:56:08', '2023-02-28 11:56:08'),
        (539, 539, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-02-28 19:56:41', '2023-02-28 11:56:41'),
        (540, 540, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-02-28 19:57:07', '2023-02-28 11:57:07'),
        (541, 541, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-02-28 19:58:04', '2023-02-28 11:58:04'),
        (542, 542, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-02-28 19:58:35', '2023-02-28 11:58:35'),
        (543, 543, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-02-28 19:59:33', '2023-02-28 11:59:32'),
        (544, 544, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-02-28 20:00:04', '2023-02-28 12:00:03'),
        (545, 545, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-02-28 20:00:29', '2023-02-28 12:00:29'),
        (546, 546, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-02-28 20:01:01', '2023-02-28 12:01:00'),
        (547, 547, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-02-28 20:01:48', '2023-02-28 12:01:47'),
        (548, 548, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-02-28 20:02:22', '2023-02-28 12:02:21'),
        (549, 549, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-02-28 20:03:23', '2023-02-28 12:03:23'),
        (550, 550, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-02-28 20:03:48', '2023-02-28 12:03:47'),
        (551, 551, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-02-28 20:04:11', '2023-02-28 12:04:11'),
        (552, 552, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-02-28 20:04:39', '2023-02-28 12:04:38'),
        (553, 553, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-02-28 20:05:35', '2023-02-28 12:05:35'),
        (554, 554, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-08-23 16:40:16', '2023-08-23 04:55:49'),
        (555, 555, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-03-01 14:12:45', '2023-03-01 06:12:45'),
        (556, 556, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-03-01 14:13:29', '2023-03-01 06:13:28'),
        (557, 557, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-03-01 14:14:05', '2023-03-01 06:14:05'),
        (558, 558, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-03-01 14:14:28', '2023-03-01 06:14:27'),
        (559, 559, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-03-01 14:19:00', '2023-03-01 06:19:00'),
        (560, 560, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-03-01 14:19:23', '2023-03-01 06:19:23'),
        (561, 561, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-03-01 14:19:50', '2023-03-01 06:19:50'),
        (562, 562, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-03-01 14:21:59', '2023-03-01 06:21:59'),
        (563, 563, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-03-01 14:22:45', '2023-03-01 06:22:44'),
        (564, 564, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-03-01 14:25:42', '2023-03-01 06:25:42'),
        (565, 565, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-03-01 14:26:11', '2023-03-01 06:26:11'),
        (566, 566, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-03-01 14:26:39', '2023-03-01 06:26:39'),
        (567, 567, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-03-01 14:27:00', '2023-03-01 06:27:00'),
        (568, 568, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-03-01 14:27:24', '2023-03-01 06:27:24'),
        (569, 569, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-03-01 14:27:47', '2023-03-01 06:27:46'),
        (570, 570, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-03-01 14:28:14', '2023-03-01 06:28:13'),
        (571, 571, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-03-01 14:29:13', '2023-03-01 06:29:12'),
        (572, 572, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-03-01 14:30:07', '2023-03-01 06:30:07'),
        (573, 573, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-03-01 14:31:54', '2023-03-01 06:31:54'),
        (574, 574, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-03-01 14:33:54', '2023-03-01 06:33:53'),
        (575, 575, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-03-01 14:34:28', '2023-03-01 06:34:28'),
        (576, 576, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-03-01 14:45:31', '2023-03-01 06:45:30'),
        (577, 577, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-03-01 14:47:11', '2023-03-01 06:47:10'),
        (578, 578, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-03-01 14:47:33', '2023-03-01 06:47:32'),
        (579, 579, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-03-01 14:48:27', '2023-03-01 06:48:26'),
        (580, 580, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-03-01 14:48:49', '2023-03-01 06:48:49'),
        (581, 581, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-03-01 14:49:15', '2023-03-01 06:49:14'),
        (582, 582, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-03-01 14:50:06', '2023-03-01 06:50:06'),
        (583, 583, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-03-01 14:50:41', '2023-03-01 06:50:41'),
        (584, 584, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-03-01 14:51:08', '2023-03-01 06:51:07'),
        (585, 585, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-03-01 14:52:49', '2023-03-01 06:52:48'),
        (586, 586, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-03-01 14:53:29', '2023-03-01 06:53:29'),
        (587, 587, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-03-01 14:54:49', '2023-03-01 06:54:48'),
        (588, 588, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-03-01 14:55:19', '2023-03-01 06:55:18'),
        (589, 589, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-03-01 14:55:46', '2023-03-01 06:55:45'),
        (590, 590, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-03-01 14:57:16', '2023-03-01 06:57:15'),
        (591, 591, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-03-01 14:57:53', '2023-03-01 06:57:52'),
        (592, 592, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-03-01 14:58:45', '2023-03-01 06:58:45'),
        (593, 593, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-03-01 14:59:38', '2023-03-01 06:59:37'),
        (594, 594, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-03-01 15:00:14', '2023-03-01 07:00:13'),
        (595, 595, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-03-01 15:00:53', '2023-03-01 07:00:53'),
        (596, 596, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-03-01 15:01:21', '2023-03-01 07:01:20'),
        (597, 597, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-03-01 15:02:03', '2023-03-01 07:02:02'),
        (598, 598, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-03-01 15:02:47', '2023-03-01 07:02:47'),
        (599, 599, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-03-01 15:03:15', '2023-03-01 07:03:15'),
        (600, 600, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-03-01 15:04:51', '2023-03-01 07:04:51'),
        (601, 601, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-03-01 15:06:00', '2023-03-01 07:05:59'),
        (602, 602, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-03-01 15:08:20', '2023-03-01 07:08:20'),
        (603, 603, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-03-01 15:08:53', '2023-03-01 07:08:53'),
        (604, 604, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-03-01 15:10:03', '2023-03-01 07:10:02'),
        (605, 605, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-03-01 15:14:31', '2023-03-01 07:14:31'),
        (606, 606, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-03-01 15:18:39', '2023-03-01 07:18:39'),
        (607, 607, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-03-01 15:21:41', '2023-03-01 07:21:41'),
        (608, 608, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-03-01 15:22:47', '2023-03-01 07:22:47'),
        (609, 609, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-03-01 15:25:05', '2023-03-01 07:25:04'),
        (610, 610, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-03-01 15:26:28', '2023-03-01 07:26:28'),
        (611, 611, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-03-01 15:27:08', '2023-03-01 07:27:07'),
        (612, 612, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-03-01 15:27:44', '2023-03-01 07:27:44'),
        (613, 613, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-03-01 15:30:38', '2023-03-01 07:30:37'),
        (614, 614, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-03-01 15:32:35', '2023-03-01 07:32:35'),
        (615, 615, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-03-01 15:33:10', '2023-03-01 07:33:09'),
        (616, 616, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-03-01 15:36:10', '2023-03-01 07:36:10'),
        (617, 617, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-03-01 15:38:30', '2023-03-01 07:38:29'),
        (618, 618, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-03-01 15:44:52', '2023-03-01 07:44:52'),
        (619, 619, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-03-01 15:46:42', '2023-03-01 07:46:42'),
        (620, 620, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-03-01 15:47:28', '2023-03-01 07:47:28'),
        (621, 621, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-03-01 15:48:03', '2023-03-01 07:48:02'),
        (622, 622, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-03-01 15:55:21', '2023-03-01 07:55:21'),
        (623, 623, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-03-01 15:55:57', '2023-03-01 07:55:57'),
        (624, 624, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-03-01 15:56:27', '2023-03-01 07:56:26'),
        (625, 625, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-03-01 15:57:07', '2023-03-01 07:57:06'),
        (626, 626, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-03-01 15:57:42', '2023-03-01 07:57:42'),
        (627, 627, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-03-01 15:58:26', '2023-03-01 07:58:26'),
        (628, 628, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-03-01 16:09:10', '2023-03-01 08:09:10'),
        (629, 629, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-03-01 16:12:37', '2023-03-01 08:12:37'),
        (630, 630, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-03-01 16:13:04', '2023-03-01 08:13:03'),
        (631, 631, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-03-01 16:13:32', '2023-03-01 08:13:32'),
        (632, 632, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-03-01 16:14:33', '2023-03-01 08:14:33'),
        (633, 633, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-03-01 16:14:57', '2023-03-01 08:14:56'),
        (634, 634, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-03-01 16:15:30', '2023-03-01 08:15:30'),
        (635, 635, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-03-01 16:16:02', '2023-03-01 08:16:01'),
        (636, 636, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-03-01 16:16:27', '2023-03-01 08:16:27'),
        (637, 637, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-03-01 16:17:52', '2023-03-01 08:17:51'),
        (638, 638, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-03-01 16:18:16', '2023-03-01 08:18:16'),
        (639, 639, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-03-01 16:18:45', '2023-03-01 08:18:45'),
        (640, 640, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-03-01 16:19:12', '2023-03-01 08:19:11'),
        (641, 641, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-03-01 16:19:39', '2023-03-01 08:19:38'),
        (642, 642, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-03-01 16:21:28', '2023-03-01 08:21:28'),
        (643, 643, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-03-01 16:22:04', '2023-03-01 08:22:04'),
        (644, 644, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-03-01 16:22:45', '2023-03-01 08:22:44'),
        (645, 645, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-03-01 16:23:25', '2023-03-01 08:23:25'),
        (646, 646, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-03-01 16:24:00', '2023-03-01 08:23:59'),
        (647, 647, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-03-01 16:24:46', '2023-03-01 08:24:45'),
        (648, 648, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-03-01 16:25:24', '2023-03-01 08:25:23'),
        (649, 649, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-03-01 16:26:25', '2023-03-01 08:26:25'),
        (650, 650, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-03-01 16:26:58', '2023-03-01 08:26:57'),
        (651, 651, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-03-01 16:27:28', '2023-03-01 08:27:28'),
        (652, 652, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-03-01 16:31:24', '2023-03-01 08:31:23'),
        (653, 653, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-03-01 16:32:01', '2023-03-01 08:32:01'),
        (654, 654, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-03-01 16:32:37', '2023-03-01 08:32:37'),
        (655, 655, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-03-01 16:34:22', '2023-03-01 08:34:22'),
        (656, 656, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-03-01 16:34:57', '2023-03-01 08:34:57'),
        (657, 657, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-03-01 16:35:26', '2023-03-01 08:35:25'),
        (658, 658, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-03-01 16:35:51', '2023-03-01 08:35:51'),
        (659, 659, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-03-01 16:36:14', '2023-03-01 08:36:13'),
        (660, 660, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-03-01 16:36:37', '2023-03-01 08:36:37'),
        (661, 661, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-03-01 16:36:55', '2023-03-01 08:36:55'),
        (662, 662, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-03-01 16:37:32', '2023-03-01 08:37:31'),
        (663, 663, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-03-01 16:37:58', '2023-03-01 08:37:57'),
        (664, 664, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-03-01 16:38:23', '2023-03-01 08:38:23'),
        (665, 665, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-03-01 16:38:55', '2023-03-01 08:38:54'),
        (666, 666, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-03-01 16:39:41', '2023-03-01 08:39:41'),
        (667, 667, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-03-01 16:40:02', '2023-03-01 08:40:01'),
        (668, 668, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-03-01 16:40:21', '2023-03-01 08:40:21'),
        (669, 669, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-03-01 16:43:13', '2023-03-01 08:43:13'),
        (670, 670, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-03-01 16:43:36', '2023-03-01 08:43:36'),
        (671, 671, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-03-01 16:43:52', '2023-03-01 08:43:51'),
        (672, 672, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-03-01 16:44:14', '2023-03-01 08:44:13'),
        (673, 673, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-03-01 16:49:33', '2023-03-01 08:49:33'),
        (674, 674, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-03-01 16:49:52', '2023-03-01 08:49:51'),
        (675, 675, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-03-01 16:50:10', '2023-03-01 08:50:10'),
        (676, 676, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-03-01 16:50:50', '2023-03-01 08:50:50'),
        (677, 677, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-03-01 16:51:12', '2023-03-01 08:51:11'),
        (678, 678, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-03-01 16:51:30', '2023-03-01 08:51:30'),
        (679, 679, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-03-01 16:51:46', '2023-03-01 08:51:45'),
        (680, 680, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-03-01 16:52:06', '2023-03-01 08:52:05'),
        (681, 681, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-03-01 16:52:23', '2023-03-01 08:52:22'),
        (682, 682, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-03-01 16:52:58', '2023-03-01 08:52:58'),
        (683, 683, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-03-01 16:53:22', '2023-03-01 08:53:22'),
        (684, 684, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-03-01 16:53:50', '2023-03-01 08:53:50'),
        (685, 685, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-03-01 16:54:11', '2023-03-01 08:54:10'),
        (686, 686, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-03-01 16:54:29', '2023-03-01 08:54:28'),
        (687, 687, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-03-01 16:54:49', '2023-03-01 08:54:48'),
        (688, 688, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-03-01 16:55:06', '2023-03-01 08:55:05'),
        (689, 689, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-03-01 16:55:34', '2023-03-01 08:55:33'),
        (690, 690, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-03-01 16:56:02', '2023-03-01 08:56:01'),
        (691, 691, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-03-01 16:56:25', '2023-03-01 08:56:24'),
        (692, 692, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-03-01 16:56:43', '2023-03-01 08:56:42'),
        (693, 693, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-03-01 16:56:59', '2023-03-01 08:56:58'),
        (694, 694, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-03-01 16:57:46', '2023-03-01 08:57:45'),
        (695, 695, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-03-01 16:58:01', '2023-03-01 08:58:00'),
        (696, 696, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-03-01 16:58:48', '2023-03-01 08:58:48'),
        (697, 697, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-03-01 16:59:08', '2023-03-01 08:59:07'),
        (698, 698, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-03-01 16:59:41', '2023-03-01 08:59:41'),
        (699, 699, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-03-01 17:00:09', '2023-03-01 09:00:09'),
        (700, 700, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-03-01 17:00:46', '2023-03-01 09:00:45'),
        (701, 701, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-03-01 17:01:29', '2023-03-01 09:01:29'),
        (702, 702, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-03-01 17:01:46', '2023-03-01 09:01:45'),
        (703, 703, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-03-01 17:02:03', '2023-03-01 09:02:02'),
        (704, 704, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-03-01 17:02:50', '2023-03-01 09:02:49'),
        (705, 705, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-03-01 17:20:14', '2023-03-01 09:20:14'),
        (706, 706, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-03-01 17:20:43', '2023-03-01 09:20:42'),
        (707, 707, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-03-01 17:21:06', '2023-03-01 09:21:05'),
        (708, 708, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-03-01 17:21:28', '2023-03-01 09:21:28'),
        (709, 709, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-03-01 17:22:08', '2023-03-01 09:22:08'),
        (710, 710, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-03-01 17:22:33', '2023-03-01 09:22:33'),
        (711, 711, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-03-01 17:22:54', '2023-03-01 09:22:53'),
        (712, 712, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-03-01 17:23:12', '2023-03-01 09:23:12'),
        (713, 713, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-03-01 17:23:55', '2023-03-01 09:23:55'),
        (714, 714, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-03-01 17:24:10', '2023-03-01 09:24:09'),
        (715, 715, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-03-01 17:24:54', '2023-03-01 09:24:54'),
        (716, 716, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-03-01 17:25:30', '2023-03-01 09:25:29'),
        (717, 717, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-03-01 17:25:50', '2023-03-01 09:25:49'),
        (718, 718, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-03-01 17:26:09', '2023-03-01 09:26:08'),
        (719, 719, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-03-01 17:26:29', '2023-03-01 09:26:29'),
        (720, 720, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-03-01 17:27:05', '2023-03-01 09:27:05'),
        (721, 721, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-03-01 17:27:49', '2023-03-01 09:27:49'),
        (722, 722, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-03-01 17:28:14', '2023-03-01 09:28:13'),
        (723, 723, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-03-01 17:29:11', '2023-03-01 09:29:11'),
        (724, 724, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-03-01 17:29:44', '2023-03-01 09:29:43'),
        (725, 725, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-03-01 21:05:07', '2023-03-01 13:05:06'),
        (726, 726, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-03-02 13:07:11', '2023-03-02 05:07:11'),
        (727, 727, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-03-04 18:20:22', '2023-03-04 10:20:21'),
        (728, 728, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-03-04 18:22:07', '2023-03-04 10:22:06'),
        (729, 729, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-03-04 18:22:54', '2023-03-04 10:22:54'),
        (730, 730, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-03-04 18:23:17', '2023-03-04 10:23:17'),
        (731, 731, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-03-04 18:23:35', '2023-03-04 10:23:35'),
        (732, 732, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-03-04 18:23:48', '2023-03-04 10:23:48'),
        (733, 733, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-03-04 18:24:17', '2023-03-04 10:24:16'),
        (734, 734, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-03-04 18:25:44', '2023-03-04 10:25:43'),
        (735, 735, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-03-04 18:26:13', '2023-03-04 10:26:12'),
        (736, 736, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-03-04 18:27:03', '2023-03-04 10:27:02'),
        (737, 737, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-03-04 18:27:22', '2023-03-04 10:27:21'),
        (738, 738, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-03-04 18:28:26', '2023-03-04 10:28:25'),
        (739, 739, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-03-04 18:28:40', '2023-03-04 10:28:39'),
        (740, 740, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-03-04 18:28:57', '2023-03-04 10:28:56'),
        (741, 741, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-03-04 18:29:22', '2023-03-04 10:29:22'),
        (742, 742, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-03-04 18:29:38', '2023-03-04 10:29:37'),
        (743, 743, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-03-04 18:29:53', '2023-03-04 10:29:53'),
        (744, 744, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-03-04 18:30:16', '2023-03-04 10:30:16'),
        (745, 745, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-03-04 18:30:30', '2023-03-04 10:30:29'),
        (746, 746, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-03-04 18:30:53', '2023-03-04 10:30:52'),
        (747, 747, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-03-04 18:31:10', '2023-03-04 10:31:10'),
        (748, 748, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-03-04 18:31:28', '2023-03-04 10:31:27'),
        (749, 749, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-03-04 18:31:42', '2023-03-04 10:31:41'),
        (750, 750, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-03-04 18:33:02', '2023-03-04 10:33:02'),
        (751, 751, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-03-04 18:35:01', '2023-03-04 10:35:00'),
        (752, 752, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-03-04 18:35:23', '2023-03-04 10:35:23'),
        (753, 753, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-03-04 18:36:35', '2023-03-04 10:36:35'),
        (754, 754, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-03-04 18:37:15', '2023-03-04 10:37:15'),
        (755, 755, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-03-04 18:37:39', '2023-03-04 10:37:38'),
        (756, 756, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-03-04 18:38:02', '2023-03-04 10:38:02'),
        (757, 757, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-03-04 18:38:51', '2023-03-04 10:38:50'),
        (758, 758, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-03-04 18:39:30', '2023-03-04 10:39:30'),
        (759, 759, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-03-04 18:40:30', '2023-03-04 10:40:30'),
        (760, 760, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-03-04 18:41:01', '2023-03-04 10:41:00'),
        (761, 761, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-03-04 18:41:43', '2023-03-04 10:41:43'),
        (762, 762, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-03-04 18:48:52', '2023-03-04 10:48:51'),
        (763, 763, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-03-04 18:49:09', '2023-03-04 10:49:08'),
        (764, 764, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-03-04 18:49:27', '2023-03-04 10:49:27'),
        (765, 765, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-03-04 18:49:42', '2023-03-04 10:49:42'),
        (766, 766, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-03-04 18:50:06', '2023-03-04 10:50:05'),
        (767, 767, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-03-04 18:50:28', '2023-03-04 10:50:27'),
        (768, 768, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-03-04 18:50:49', '2023-03-04 10:50:48'),
        (769, 769, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-03-04 18:51:11', '2023-03-04 10:51:11'),
        (770, 770, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-03-04 18:51:28', '2023-03-04 10:51:27'),
        (771, 771, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-03-04 18:51:44', '2023-03-04 10:51:44'),
        (772, 772, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-03-04 18:52:02', '2023-03-04 10:52:01'),
        (773, 773, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-03-04 18:52:21', '2023-03-04 10:52:20'),
        (774, 774, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-03-04 18:52:37', '2023-03-04 10:52:37'),
        (775, 775, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-03-04 18:52:54', '2023-03-04 10:52:54'),
        (776, 776, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-03-04 18:53:29', '2023-03-04 10:53:28'),
        (777, 777, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-03-04 18:53:48', '2023-03-04 10:53:47'),
        (778, 778, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-03-04 18:54:07', '2023-03-04 10:54:06'),
        (779, 779, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-03-04 18:54:26', '2023-03-04 10:54:25'),
        (780, 780, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-03-04 18:54:44', '2023-03-04 10:54:44'),
        (781, 781, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-03-04 18:55:05', '2023-03-04 10:55:04'),
        (782, 782, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-03-04 18:56:37', '2023-03-04 10:56:37'),
        (783, 783, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-03-04 18:56:52', '2023-03-04 10:56:52'),
        (784, 784, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-03-04 18:57:06', '2023-03-04 10:57:06'),
        (785, 785, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-03-04 18:57:23', '2023-03-04 10:57:22'),
        (786, 786, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-03-04 18:57:45', '2023-03-04 10:57:45'),
        (787, 787, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-03-04 18:58:05', '2023-03-04 10:58:05'),
        (788, 788, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-03-04 18:58:25', '2023-03-04 10:58:24'),
        (789, 789, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-03-04 18:58:47', '2023-03-04 10:58:47'),
        (790, 790, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-03-04 18:59:05', '2023-03-04 10:59:05'),
        (791, 791, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-03-04 18:59:29', '2023-03-04 10:59:28'),
        (792, 792, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-03-04 18:59:48', '2023-03-04 10:59:47'),
        (793, 793, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-03-04 19:00:10', '2023-03-04 11:00:09'),
        (794, 794, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-03-04 19:00:24', '2023-03-04 11:00:23'),
        (795, 795, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-03-04 19:00:41', '2023-03-04 11:00:40'),
        (796, 796, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-03-04 19:01:01', '2023-03-04 11:01:01'),
        (797, 797, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-03-04 19:01:17', '2023-03-04 11:01:17'),
        (798, 798, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-03-04 19:01:48', '2023-03-04 11:01:47'),
        (799, 799, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-03-04 19:02:17', '2023-03-04 11:02:16'),
        (800, 800, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-03-04 19:02:34', '2023-03-04 11:02:34'),
        (801, 801, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-03-04 19:02:55', '2023-03-04 11:02:55'),
        (802, 802, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-03-04 19:03:37', '2023-03-04 11:03:36'),
        (803, 803, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-03-04 19:04:00', '2023-03-04 11:03:59'),
        (804, 804, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-03-04 19:04:19', '2023-03-04 11:04:18'),
        (805, 805, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-03-04 19:04:40', '2023-03-04 11:04:39'),
        (806, 806, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-03-04 19:06:03', '2023-03-04 11:06:02'),
        (807, 807, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-03-04 19:06:19', '2023-03-04 11:06:19'),
        (808, 808, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-03-04 19:06:36', '2023-03-04 11:06:36'),
        (809, 809, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-03-04 19:06:51', '2023-03-04 11:06:51'),
        (810, 810, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-03-04 19:07:08', '2023-03-04 11:07:08'),
        (811, 811, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-03-04 19:08:57', '2023-03-04 11:08:56'),
        (812, 812, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-03-04 19:09:14', '2023-03-04 11:09:13'),
        (813, 813, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-03-04 19:09:38', '2023-03-04 11:09:38'),
        (814, 814, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-03-04 19:10:17', '2023-03-04 11:10:16'),
        (815, 815, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-03-04 19:11:35', '2023-03-04 11:11:35'),
        (816, 816, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-03-04 19:11:57', '2023-03-04 11:11:57'),
        (817, 817, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-03-04 19:12:39', '2023-03-04 11:12:38'),
        (818, 818, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-03-04 19:12:58', '2023-03-04 11:12:57'),
        (819, 819, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-03-04 19:13:23', '2023-03-04 11:13:22'),
        (820, 820, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-03-04 19:13:41', '2023-03-04 11:13:40'),
        (821, 821, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-03-04 19:13:58', '2023-03-04 11:13:58'),
        (822, 822, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-03-04 19:14:19', '2023-03-04 11:14:19'),
        (823, 823, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-03-04 19:14:43', '2023-03-04 11:14:42'),
        (824, 824, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-03-04 19:15:12', '2023-03-04 11:15:12'),
        (825, 825, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-03-04 19:15:37', '2023-03-04 11:15:37'),
        (826, 826, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-03-04 19:16:00', '2023-03-04 11:16:00'),
        (827, 827, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-03-04 19:16:24', '2023-03-04 11:16:24'),
        (828, 828, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-03-04 19:16:48', '2023-03-04 11:16:47'),
        (829, 829, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-03-04 19:17:31', '2023-03-04 11:17:30'),
        (830, 830, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-03-04 19:17:57', '2023-03-04 11:17:57'),
        (831, 831, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-03-04 19:19:28', '2023-03-04 11:19:28'),
        (832, 832, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-03-04 19:19:51', '2023-03-04 11:19:51'),
        (833, 833, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-03-04 19:20:18', '2023-03-04 11:20:18'),
        (834, 834, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-03-04 19:28:15', '2023-03-04 11:28:15'),
        (835, 835, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-03-04 19:28:33', '2023-03-04 11:28:33'),
        (836, 836, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-03-04 19:28:49', '2023-03-04 11:28:48'),
        (837, 837, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-03-04 19:29:24', '2023-03-04 11:29:24'),
        (838, 838, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-03-04 19:29:49', '2023-03-04 11:29:48'),
        (839, 839, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-03-04 19:37:39', '2023-03-04 11:37:38'),
        (840, 840, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-03-04 19:37:56', '2023-03-04 11:37:56'),
        (841, 841, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-03-04 19:38:29', '2023-03-04 11:38:28'),
        (842, 842, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-03-04 19:38:52', '2023-03-04 11:38:51'),
        (843, 843, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-03-04 19:40:39', '2023-03-04 11:40:39'),
        (844, 844, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-03-04 19:40:54', '2023-03-04 11:40:54'),
        (845, 845, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-03-04 19:41:10', '2023-03-04 11:41:09'),
        (846, 846, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-03-04 19:41:26', '2023-03-04 11:41:26'),
        (847, 847, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-03-04 19:41:49', '2023-03-04 11:41:48'),
        (848, 848, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-03-04 19:42:09', '2023-03-04 11:42:08'),
        (849, 849, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-03-04 19:42:39', '2023-03-04 11:42:39'),
        (850, 850, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-03-04 19:42:58', '2023-03-04 11:42:58'),
        (851, 851, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-03-04 19:43:15', '2023-03-04 11:43:14'),
        (852, 852, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-03-04 19:43:43', '2023-03-04 11:43:42'),
        (853, 853, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-03-04 19:44:07', '2023-03-04 11:44:06'),
        (854, 854, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-03-04 19:44:53', '2023-03-04 11:44:53'),
        (855, 855, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-03-04 19:45:10', '2023-03-04 11:45:10'),
        (856, 856, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-03-04 19:45:41', '2023-03-04 11:45:40'),
        (857, 857, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-03-04 19:46:04', '2023-03-04 11:46:04'),
        (858, 858, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-03-04 19:46:45', '2023-03-04 11:46:44'),
        (859, 859, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-03-04 20:04:59', '2023-03-04 12:04:59'),
        (860, 860, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-03-04 20:05:57', '2023-03-04 12:05:56'),
        (861, 861, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-03-04 20:06:29', '2023-03-04 12:06:29'),
        (862, 862, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-03-04 20:07:12', '2023-03-04 12:07:12'),
        (863, 863, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-03-04 20:07:31', '2023-03-04 12:07:31'),
        (864, 864, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-03-04 20:07:49', '2023-03-04 12:07:49'),
        (865, 865, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-03-04 20:08:10', '2023-03-04 12:08:10'),
        (866, 866, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-03-04 20:08:34', '2023-03-04 12:08:33'),
        (867, 867, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-03-04 20:08:58', '2023-03-04 12:08:58'),
        (868, 868, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-03-04 20:11:06', '2023-03-04 12:11:06'),
        (869, 869, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-03-04 20:11:36', '2023-03-04 12:11:35'),
        (870, 870, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-03-04 20:12:32', '2023-03-04 12:12:31'),
        (871, 871, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-03-04 20:17:51', '2023-03-04 12:17:50'),
        (872, 872, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-03-04 20:18:05', '2023-03-04 12:18:04'),
        (873, 873, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-03-04 20:18:21', '2023-03-04 12:18:21'),
        (874, 874, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-03-04 20:18:45', '2023-03-04 12:18:45'),
        (875, 875, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-03-04 20:19:00', '2023-03-04 12:19:00'),
        (876, 876, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-03-04 20:19:13', '2023-03-04 12:19:13'),
        (877, 877, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-03-04 20:19:32', '2023-03-04 12:19:32'),
        (878, 878, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-05-13 18:44:49', '2023-05-13 10:44:49'),
        (879, 879, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-05-14 19:00:40', '2023-05-14 11:00:40'),
        (880, 880, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-05-14 19:01:21', '2023-05-14 11:01:21'),
        (881, 881, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-05-14 19:02:26', '2023-05-14 11:02:26'),
        (882, 882, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-05-14 19:02:43', '2023-05-14 11:02:43'),
        (883, 883, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-05-14 19:02:57', '2023-05-14 11:02:57'),
        (884, 884, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-05-14 19:04:50', '2023-05-14 11:04:49'),
        (885, 885, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-05-14 19:05:56', '2023-05-14 11:05:56'),
        (886, 886, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-05-14 19:06:39', '2023-05-14 11:06:38'),
        (887, 887, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-05-14 19:07:24', '2023-05-14 11:07:23'),
        (888, 888, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-05-14 19:07:59', '2023-05-14 11:07:59'),
        (889, 889, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-05-14 19:15:34', '2023-05-14 11:15:34'),
        (890, 890, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-05-14 20:00:00', '2023-05-14 12:00:00'),
        (891, 891, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-05-15 12:04:43', '2023-05-15 04:04:43'),
        (892, 892, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-05-15 12:07:26', '2023-05-15 04:07:26'),
        (893, 893, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-05-15 12:08:46', '2023-05-15 04:08:45'),
        (894, 894, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-05-15 12:10:01', '2023-05-15 04:10:00'),
        (895, 895, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-05-15 12:11:21', '2023-05-15 04:11:21'),
        (896, 896, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-05-15 15:59:15', '2023-05-15 07:59:15'),
        (897, 897, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-05-15 20:11:13', '2023-05-15 12:11:13'),
        (898, 898, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-05-15 20:13:06', '2023-05-15 12:13:05'),
        (899, 899, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-05-15 20:16:30', '2023-05-15 12:16:30'),
        (900, 900, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-05-15 20:17:33', '2023-05-15 12:17:32'),
        (901, 901, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-05-15 21:56:29', '2023-05-15 13:56:28'),
        (902, 902, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-05-16 14:37:52', '2023-05-16 06:37:52'),
        (903, 903, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-05-16 14:56:04', '2023-05-16 06:56:03'),
        (904, 904, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-05-16 14:58:28', '2023-05-16 06:58:28'),
        (905, 905, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-05-17 19:02:44', '2023-05-17 11:02:43'),
        (906, 906, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-05-18 18:28:32', '2023-05-18 10:28:32'),
        (907, 907, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-05-18 18:33:00', '2023-05-18 10:32:59'),
        (908, 908, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-05-18 20:17:49', '2023-05-18 12:17:49'),
        (909, 909, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-05-19 20:06:20', '2023-05-19 12:06:20'),
        (910, 910, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-05-20 20:09:30', '2023-05-20 12:09:30'),
        (911, 911, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-05-27 17:21:15', '2023-05-27 09:21:15'),
        (912, 912, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-05-27 20:04:56', '2023-05-27 12:04:56'),
        (913, 913, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-05-27 20:26:48', '2023-05-27 12:26:48'),
        (914, 914, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-06-10 19:37:29', '2023-06-10 11:37:29'),
        (915, 915, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-06-10 19:47:36', '2023-06-10 11:47:35'),
        (916, 916, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-06-10 19:51:25', '2023-06-10 11:51:25'),
        (917, 917, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-06-10 19:56:57', '2023-06-10 11:56:56'),
        (918, 918, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-06-10 22:10:31', '2023-06-10 14:10:30'),
        (919, 919, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-06-11 20:21:23', '2023-06-11 12:21:23'),
        (920, 920, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-06-11 20:34:15', '2023-06-11 12:34:14'),
        (921, 921, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-06-13 17:55:58', '2023-06-13 09:55:58'),
        (922, 922, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-06-13 20:03:50', '2023-06-13 12:03:50'),
        (923, 923, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-06-13 20:25:33', '2023-06-13 12:25:32'),
        (924, 924, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-06-13 20:45:55', '2023-06-13 12:45:55'),
        (925, 925, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-06-14 20:43:25', '2023-06-14 12:43:24'),
        (926, 926, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-06-14 21:22:02', '2023-06-14 13:22:01'),
        (927, 927, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-06-14 21:24:33', '2023-06-14 13:24:33'),
        (928, 928, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-06-19 21:56:09', '2023-06-19 13:56:09'),
        (929, 929, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-06-21 20:06:19', '2023-06-21 12:06:18'),
        (930, 930, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-06-21 20:06:21', '2023-06-21 12:06:20'),
        (931, 931, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-06-21 20:13:42', '2023-06-21 12:13:41'),
        (932, 932, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-06-21 20:29:06', '2023-06-21 12:29:05'),
        (933, 933, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-06-21 20:29:33', '2023-06-21 12:29:33'),
        (934, 934, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-06-21 20:30:30', '2023-06-21 12:30:29'),
        (935, 935, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-06-21 20:31:54', '2023-06-21 12:31:54'),
        (936, 936, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-06-21 20:32:30', '2023-06-21 12:32:29'),
        (937, 937, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-06-21 20:46:04', '2023-06-21 12:46:04'),
        (938, 938, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-06-21 20:47:32', '2023-06-21 12:47:32'),
        (939, 939, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-06-21 20:49:22', '2023-06-21 12:49:22'),
        (940, 940, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-06-23 19:44:22', '2023-06-23 11:44:21'),
        (941, 941, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-06-24 21:04:36', '2023-06-24 13:04:36'),
        (942, 942, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-06-24 21:04:45', '2023-06-24 13:04:44'),
        (943, 943, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-06-24 21:06:08', '2023-06-24 13:06:07'),
        (944, 944, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-06-24 21:06:51', '2023-06-24 13:06:50'),
        (945, 945, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-06-24 21:07:28', '2023-06-24 13:07:27'),
        (946, 946, 1, 1000.00, 306.00, 694.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-06-26 16:55:52', '2023-08-30 05:10:55'),
        (947, 947, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-07-02 20:24:08', '2023-07-02 12:24:07'),
        (948, 948, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-07-08 17:16:13', '2023-07-08 09:16:12'),
        (949, 949, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-07-08 17:36:24', '2023-07-08 09:36:24'),
        (950, 950, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-07-08 18:24:22', '2023-07-08 10:24:21'),
        (951, 951, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-07-08 18:26:13', '2023-07-08 10:26:13'),
        (952, 952, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-07-08 18:27:44', '2023-07-08 10:27:44'),
        (953, 953, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-07-08 18:44:26', '2023-07-08 10:44:26'),
        (954, 954, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-07-08 19:10:51', '2023-07-08 11:10:50'),
        (955, 955, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-07-08 19:32:52', '2023-07-08 11:32:52'),
        (956, 956, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-07-08 19:57:56', '2023-07-08 11:57:56'),
        (957, 957, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-07-08 20:19:45', '2023-07-08 12:19:45'),
        (958, 958, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-07-08 20:27:05', '2023-07-08 12:27:04'),
        (959, 959, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-07-08 21:06:43', '2023-07-08 13:06:43'),
        (960, 960, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-07-08 21:17:03', '2023-07-08 13:17:03'),
        (961, 961, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-07-08 21:41:05', '2023-07-08 13:41:05'),
        (962, 962, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-07-08 21:43:49', '2023-07-08 13:43:48'),
        (963, 963, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-07-08 21:57:13', '2023-07-08 13:57:13'),
        (964, 964, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-07-08 22:10:27', '2023-07-08 14:10:27'),
        (965, 965, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-07-08 22:21:03', '2023-07-08 14:21:02'),
        (966, 966, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-07-08 22:37:02', '2023-07-08 14:37:01'),
        (967, 967, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-07-08 23:08:02', '2023-07-08 15:08:01'),
        (968, 968, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-07-09 01:04:23', '2023-07-08 17:04:23'),
        (969, 969, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-07-09 02:01:21', '2023-07-08 18:01:20'),
        (970, 970, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-07-09 02:15:38', '2023-07-08 18:15:37'),
        (971, 971, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-07-09 06:29:08', '2023-07-08 22:29:08'),
        (972, 972, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-07-09 06:56:07', '2023-07-08 22:56:06'),
        (973, 973, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-07-09 07:22:49', '2023-07-08 23:22:48'),
        (974, 974, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-07-09 09:00:05', '2023-07-09 01:00:04'),
        (975, 975, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-07-09 09:12:07', '2023-07-09 01:12:07'),
        (976, 976, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-07-09 10:40:36', '2023-07-09 02:40:36'),
        (977, 977, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-07-09 10:40:36', '2023-07-09 02:40:36'),
        (978, 978, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-07-09 11:54:29', '2023-07-09 03:54:29'),
        (979, 979, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-07-09 12:53:17', '2023-07-09 04:53:16'),
        (980, 980, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-07-09 13:25:19', '2023-07-09 05:25:18'),
        (981, 981, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-07-09 13:54:48', '2023-07-09 05:54:47'),
        (982, 982, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-07-09 15:42:22', '2023-07-09 07:42:21'),
        (983, 983, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-07-09 17:17:00', '2023-07-09 09:16:59'),
        (984, 984, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-07-09 17:20:19', '2023-07-09 09:20:19'),
        (985, 985, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-07-09 22:00:18', '2023-07-09 14:00:17'),
        (986, 986, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-07-09 22:44:55', '2023-07-09 14:44:55'),
        (987, 987, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-07-11 00:24:14', '2023-07-10 16:24:14'),
        (988, 988, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-07-11 00:36:23', '2023-07-10 16:36:22'),
        (989, 989, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-07-11 08:03:21', '2023-07-11 00:03:20'),
        (990, 990, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-07-11 15:14:24', '2023-07-11 07:14:24'),
        (991, 991, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-07-11 16:19:02', '2023-07-11 08:19:02'),
        (992, 992, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-07-11 16:40:06', '2023-07-11 08:40:06'),
        (993, 993, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-07-11 17:28:34', '2023-07-11 09:28:34'),
        (994, 994, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-07-11 18:19:42', '2023-07-11 10:19:41'),
        (995, 995, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-07-11 19:05:50', '2023-07-11 11:05:49'),
        (996, 996, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-07-11 19:31:48', '2023-07-11 11:31:48'),
        (997, 997, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-07-11 20:01:12', '2023-07-11 12:01:11'),
        (998, 998, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-07-11 20:53:44', '2023-07-11 12:53:44'),
        (999, 999, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-07-11 20:56:27', '2023-07-11 12:56:26'),
        (1000, 1000, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-07-11 21:00:38', '2023-07-11 13:00:37'),
        (1001, 1001, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-07-11 21:01:21', '2023-07-11 13:01:21'),
        (1002, 1002, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-07-11 21:23:35', '2023-07-11 13:23:35'),
        (1003, 1003, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-07-11 21:32:37', '2023-07-11 13:32:37'),
        (1004, 1004, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-07-11 21:35:55', '2023-07-11 13:35:55'),
        (1005, 1005, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-07-11 21:51:50', '2023-07-11 13:51:49'),
        (1006, 1006, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-07-11 21:53:27', '2023-07-11 13:53:27'),
        (1007, 1007, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-07-11 22:32:52', '2023-07-11 14:32:51'),
        (1008, 1008, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-07-11 23:14:47', '2023-07-11 15:14:47'),
        (1009, 1009, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-07-12 00:34:46', '2023-07-11 16:34:45'),
        (1010, 1010, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-07-12 01:02:22', '2023-07-11 17:02:22'),
        (1011, 1011, 1, 5.00, 0.00, 5.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-07-12 01:03:15', '2023-07-12 18:58:51'),
        (1012, 1012, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-07-12 01:35:24', '2023-07-11 17:35:24'),
        (1013, 1013, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-07-12 01:35:40', '2023-07-11 17:35:40'),
        (1014, 1014, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-07-12 02:40:40', '2023-07-11 18:40:40'),
        (1015, 1015, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-07-12 03:34:28', '2023-07-11 19:34:28'),
        (1016, 1016, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-07-12 07:51:02', '2023-07-11 23:51:02'),
        (1017, 1017, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-07-12 08:40:25', '2023-07-12 00:40:24'),
        (1018, 1018, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-07-12 11:26:12', '2023-07-12 03:26:12'),
        (1019, 1019, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-07-12 12:08:54', '2023-07-12 04:08:54'),
        (1020, 1020, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-07-12 12:45:02', '2023-07-12 04:45:01'),
        (1021, 1021, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-07-12 14:41:17', '2023-07-12 06:41:16'),
        (1022, 1022, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-07-12 16:16:06', '2023-07-12 08:16:06'),
        (1023, 1023, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-07-12 16:24:06', '2023-07-12 08:24:06'),
        (1024, 1024, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-07-12 18:12:35', '2023-07-12 10:12:34'),
        (1025, 1025, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-07-12 18:52:37', '2023-07-12 10:52:37'),
        (1026, 1026, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-07-12 19:07:59', '2023-07-12 11:07:58'),
        (1027, 1027, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-07-12 19:38:59', '2023-07-12 11:38:59'),
        (1028, 1028, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-07-12 20:07:06', '2023-07-12 12:07:05'),
        (1029, 1029, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-07-12 20:37:36', '2023-07-12 12:37:35'),
        (1030, 1030, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-07-12 20:42:42', '2023-07-12 12:42:41'),
        (1031, 1031, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-07-12 20:45:16', '2023-07-12 12:45:15'),
        (1032, 1032, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-07-12 21:05:13', '2023-07-12 13:05:12'),
        (1033, 1033, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-07-12 21:18:53', '2023-07-12 13:18:52'),
        (1034, 1034, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-07-12 21:22:02', '2023-07-12 13:22:01'),
        (1035, 1035, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-07-12 21:28:11', '2023-07-12 13:28:11'),
        (1036, 1036, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-07-12 21:31:12', '2023-07-12 13:31:12'),
        (1037, 1037, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-07-12 21:31:46', '2023-07-12 13:31:45'),
        (1038, 1038, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-07-12 23:22:11', '2023-07-12 15:22:10'),
        (1039, 1039, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-07-12 23:41:36', '2023-07-12 15:41:36'),
        (1040, 1040, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-07-13 01:17:43', '2023-07-12 17:17:42'),
        (1041, 1041, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-07-13 01:19:23', '2023-07-12 17:19:22'),
        (1042, 1042, 1, 5.00, 0.00, 5.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-07-13 02:16:56', '2023-07-12 18:58:51'),
        (1043, 1043, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-07-13 05:31:29', '2023-07-12 21:31:29'),
        (1044, 1044, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-07-13 08:10:59', '2023-07-13 00:10:59'),
        (1045, 1045, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-07-13 14:10:53', '2023-07-13 06:10:53'),
        (1046, 1046, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-07-13 15:09:43', '2023-07-13 07:09:43'),
        (1047, 1047, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-07-13 15:23:11', '2023-07-13 07:23:10'),
        (1048, 1048, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-07-13 15:45:30', '2023-07-13 07:45:30'),
        (1049, 1049, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-07-13 19:02:00', '2023-07-13 11:01:59'),
        (1050, 1050, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-07-13 22:23:33', '2023-07-13 14:23:33'),
        (1051, 1051, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-07-13 22:42:10', '2023-07-13 14:42:09'),
        (1052, 1052, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-07-14 00:12:52', '2023-07-13 16:12:51'),
        (1053, 1053, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-07-14 02:17:41', '2023-07-13 18:17:40'),
        (1054, 1054, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-07-14 02:19:35', '2023-07-13 18:19:35'),
        (1055, 1055, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-07-14 02:24:36', '2023-07-13 18:24:35'),
        (1056, 1056, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-07-14 04:21:48', '2023-07-13 20:21:48'),
        (1057, 1057, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-07-14 08:07:55', '2023-07-14 00:07:54'),
        (1058, 1058, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-07-14 10:33:32', '2023-07-14 02:33:32'),
        (1059, 1059, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-07-14 10:44:44', '2023-07-14 02:44:43'),
        (1060, 1060, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-07-14 11:40:13', '2023-07-14 03:40:12'),
        (1061, 1061, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-07-14 18:06:09', '2023-07-14 10:06:08'),
        (1062, 1062, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-07-14 18:06:47', '2023-07-14 10:06:46'),
        (1063, 1063, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-07-14 20:52:36', '2023-07-14 12:52:35'),
        (1064, 1064, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-07-15 03:50:02', '2023-07-14 19:50:02'),
        (1065, 1065, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-07-15 07:37:14', '2023-07-14 23:37:14'),
        (1066, 1066, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-07-15 10:30:09', '2023-07-15 02:30:09'),
        (1067, 1067, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-07-15 17:34:31', '2023-07-15 09:34:31'),
        (1068, 1068, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-07-15 18:21:41', '2023-07-15 10:21:41'),
        (1069, 1069, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-07-15 18:49:32', '2023-07-15 10:49:31'),
        (1070, 1070, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-07-15 20:00:40', '2023-07-15 12:00:39'),
        (1071, 1071, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-07-15 21:45:08', '2023-07-15 13:45:07'),
        (1072, 1072, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-07-15 22:47:31', '2023-07-15 14:47:31'),
        (1073, 1073, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-07-15 22:47:50', '2023-07-15 14:47:50'),
        (1074, 1074, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-07-16 16:52:49', '2023-07-16 08:52:49'),
        (1075, 1075, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-07-16 17:46:07', '2023-07-16 09:46:07'),
        (1076, 1076, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-07-16 20:52:18', '2023-07-16 12:52:18'),
        (1077, 1077, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-07-17 21:17:52', '2023-07-17 13:17:51'),
        (1078, 1078, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-07-17 22:06:36', '2023-07-17 14:06:36'),
        (1079, 1079, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-07-21 16:08:42', '2023-07-21 08:08:41'),
        (1080, 1080, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-07-21 18:25:44', '2023-07-21 10:25:44'),
        (1081, 1081, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-07-21 19:16:58', '2023-07-21 11:16:57'),
        (1082, 1082, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-07-21 20:37:05', '2023-07-21 12:37:04'),
        (1083, 1083, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-07-21 20:59:53', '2023-07-21 12:59:52'),
        (1084, 1084, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-07-21 21:28:34', '2023-07-21 13:28:34'),
        (1085, 1085, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-07-21 21:36:08', '2023-07-21 13:36:07'),
        (1086, 1086, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-07-21 23:11:50', '2023-07-21 15:11:50'),
        (1087, 1087, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-07-21 23:20:53', '2023-07-21 15:20:52'),
        (1088, 1088, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-07-22 04:52:53', '2023-07-21 20:52:53'),
        (1089, 1089, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-07-22 07:14:25', '2023-07-21 23:14:24'),
        (1090, 1090, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-07-22 09:42:01', '2023-07-22 01:42:01'),
        (1091, 1091, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-07-22 12:26:13', '2023-07-22 04:26:13'),
        (1092, 1092, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-07-22 16:09:35', '2023-07-22 08:09:34'),
        (1093, 1093, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-07-22 16:44:58', '2023-07-22 08:44:58'),
        (1094, 1094, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-07-22 19:59:45', '2023-07-22 11:59:45'),
        (1095, 1095, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-07-22 20:10:18', '2023-07-22 12:10:17'),
        (1096, 1096, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-07-22 20:51:59', '2023-07-22 12:51:58'),
        (1097, 1097, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-07-22 21:11:44', '2023-07-22 13:11:43'),
        (1098, 1098, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-07-22 21:29:55', '2023-07-22 13:29:55'),
        (1099, 1099, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-07-22 21:52:19', '2023-07-22 13:52:18'),
        (1100, 1100, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-07-22 22:11:43', '2023-07-22 14:11:42'),
        (1101, 1101, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-07-22 22:25:14', '2023-07-22 14:25:13'),
        (1102, 1102, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-07-23 01:32:40', '2023-07-22 17:32:40'),
        (1103, 1103, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-07-23 08:25:33', '2023-07-23 00:25:33'),
        (1104, 1104, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-07-23 09:59:34', '2023-07-23 01:59:34'),
        (1105, 1105, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-07-23 11:05:44', '2023-07-23 03:05:44'),
        (1106, 1106, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-07-23 21:28:57', '2023-07-23 13:28:57'),
        (1107, 1107, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-07-23 21:43:20', '2023-07-23 13:43:19'),
        (1108, 1108, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-07-23 22:13:52', '2023-07-23 14:13:51'),
        (1109, 1109, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-07-24 08:15:26', '2023-07-24 00:15:26'),
        (1110, 1110, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-07-24 09:55:07', '2023-07-24 01:55:06'),
        (1111, 1111, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-07-24 11:19:35', '2023-07-24 03:19:34'),
        (1112, 1112, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-07-24 21:14:27', '2023-07-24 13:14:27'),
        (1113, 1113, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-07-24 21:35:28', '2023-07-24 13:35:28'),
        (1114, 1114, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-07-24 22:56:57', '2023-07-24 14:56:56'),
        (1115, 1115, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-07-25 00:24:50', '2023-07-24 16:24:50'),
        (1116, 1116, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-07-25 10:33:30', '2023-07-25 02:33:30'),
        (1117, 1117, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-07-25 10:52:45', '2023-07-25 02:52:44'),
        (1118, 1118, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-07-25 10:55:46', '2023-07-25 02:55:46'),
        (1119, 1119, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-07-25 14:04:16', '2023-07-25 06:04:16'),
        (1120, 1120, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-07-25 16:30:47', '2023-07-25 08:30:47'),
        (1121, 1121, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-07-25 17:26:20', '2023-07-25 09:26:20'),
        (1122, 1122, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-07-25 17:51:33', '2023-07-25 09:51:33'),
        (1123, 1123, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-07-25 19:21:26', '2023-07-25 11:21:25'),
        (1124, 1124, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-07-25 19:30:30', '2023-07-25 11:30:29'),
        (1125, 1125, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-07-25 20:56:15', '2023-07-25 12:56:15'),
        (1126, 1126, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-07-25 21:17:40', '2023-07-25 13:17:40'),
        (1127, 1127, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-07-25 21:17:55', '2023-07-25 13:17:54'),
        (1128, 1128, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-07-25 23:02:34', '2023-07-25 15:02:34'),
        (1129, 1129, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-07-25 23:12:12', '2023-07-25 15:12:11'),
        (1130, 1130, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-07-26 03:45:50', '2023-07-25 19:45:49'),
        (1131, 1131, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-07-26 05:41:11', '2023-07-25 21:41:11'),
        (1132, 1132, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-07-26 06:54:42', '2023-07-25 22:54:41'),
        (1133, 1133, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-07-26 09:04:24', '2023-07-26 01:04:24'),
        (1134, 1134, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-07-26 13:08:10', '2023-07-26 05:08:10'),
        (1135, 1135, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-07-26 16:04:40', '2023-07-26 08:04:40'),
        (1136, 1136, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-07-26 20:15:09', '2023-07-26 12:15:08'),
        (1137, 1137, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-07-26 21:37:56', '2023-07-26 13:37:55'),
        (1138, 1138, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-07-27 04:28:18', '2023-07-26 20:28:18'),
        (1139, 1139, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-07-27 10:55:30', '2023-07-27 02:55:30'),
        (1140, 1140, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-07-27 16:45:32', '2023-07-27 08:45:32'),
        (1141, 1141, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-07-27 16:46:15', '2023-07-27 08:46:14'),
        (1142, 1142, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-07-27 16:48:56', '2023-07-27 08:48:56'),
        (1143, 1143, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-07-27 17:18:21', '2023-07-27 09:18:20'),
        (1144, 1144, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-07-27 17:20:42', '2023-07-27 09:20:42'),
        (1145, 1145, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-07-27 18:48:41', '2023-07-27 10:48:41'),
        (1146, 1146, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-07-27 20:24:45', '2023-07-27 12:24:45'),
        (1147, 1147, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-07-27 22:12:49', '2023-07-27 14:12:48'),
        (1148, 1148, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-07-28 14:42:55', '2023-07-28 06:42:55'),
        (1149, 1149, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-07-28 17:34:56', '2023-07-28 09:34:56'),
        (1150, 1150, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-07-29 02:39:00', '2023-07-28 18:38:59'),
        (1151, 1151, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-08-23 16:40:16', '2023-08-23 04:55:49'),
        (1152, 1152, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-07-29 20:20:03', '2023-07-29 12:20:02'),
        (1153, 1153, 1, 10.00, 5.00, 5.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-07-29 21:55:17', '2023-08-21 10:54:10'),
        (1154, 1154, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-07-30 01:15:53', '2023-07-29 17:15:52'),
        (1155, 1155, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-07-30 14:13:02', '2023-07-30 06:13:02'),
        (1156, 1156, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-07-30 16:36:20', '2023-07-30 08:36:19'),
        (1157, 1157, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-07-30 16:37:08', '2023-07-30 08:37:08'),
        (1158, 1158, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-07-30 20:11:39', '2023-07-30 12:11:38'),
        (1159, 1159, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-07-31 02:01:47', '2023-07-30 18:01:47'),
        (1160, 1160, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-08-03 18:30:44', '2023-08-03 10:30:43'),
        (1161, 1161, 1, 10.00, 0.00, 10.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-08-04 18:37:46', '2023-08-23 05:18:39'),
        (1162, 1162, 1, 100.00, 0.00, 100.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-08-07 08:15:53', '2023-08-21 12:02:16'),
        (1163, 1163, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-08-07 20:24:20', '2023-08-07 12:24:20'),
        (1164, 1164, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-08-08 08:06:54', '2023-08-08 00:06:54'),
        (1165, 1165, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-08-08 10:04:58', '2023-08-08 02:04:57'),
        (1166, 1166, 1, 8333.00, 3333.00, 5000.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-08-09 10:15:46', '2023-08-22 11:48:25'),
        (1167, 1167, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-08-24 15:19:25', '2023-08-24 03:35:00'),
        (1168, 1168, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-08-24 15:21:43', '2023-08-24 03:37:18'),
        (1169, 1169, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0, 0, 0, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, null, 0.00, 1, 1, '2023-08-24 15:22:20', '2023-08-24 03:37:56');


insert into lhtk.t_account_detail (id, user_id, related_id, order_no, payment_type, amount, available_balance, freeze_amount, trade_type, item_type, status, remark, send_red_packet_user_id, create_time, update_time)
values  (1, 946, null, '', -1, 100.00, 900.00, null, 2, 1, 1, '', null, '2023-06-28 11:05:51', '2023-06-28 11:05:51'),
        (29, 1042, 1042, null, 1, 5.00, 5.00, null, 2, 1, 1, null, null, '2023-07-12 18:58:51', '2023-07-12 18:58:51'),
        (30, 1011, 1042, null, 1, 5.00, 5.00, null, 3, 1, 1, null, null, '2023-07-12 18:58:51', '2023-07-12 18:58:51'),
        (36, 1153, null, null, 1, 10.00, 10.00, null, 27, 1, 1, null, null, '2023-08-21 10:53:59', '2023-08-21 10:53:59'),
        (37, 1153, null, null, -1, 5.00, 5.00, null, 28, 1, 1, '', null, '2023-08-21 10:54:10', '2023-08-21 10:54:10'),
        (38, 946, null, null, -1, 1.00, 899.00, null, 2, 1, 1, '', null, '2023-08-21 11:43:50', '2023-08-21 11:43:50'),
        (39, 946, null, null, -1, 1.00, 898.00, null, 2, 1, 1, '', null, '2023-08-21 11:44:10', '2023-08-21 11:44:10'),
        (40, 946, null, null, -1, 200.00, 698.00, null, 2, 1, 1, '', null, '2023-08-21 11:55:02', '2023-08-21 11:55:02'),
        (41, 1162, null, null, 1, 100.00, 100.00, null, 27, 1, 1, null, null, '2023-08-21 12:02:16', '2023-08-21 12:02:16'),
        (42, 1166, null, null, 1, 1111.00, 1111.00, null, 27, 1, 1, null, null, '2023-08-22 10:54:25', '2023-08-22 10:54:25'),
        (43, 1166, null, null, -1, 1111.00, 0.00, null, 28, 1, 1, '', null, '2023-08-22 10:54:31', '2023-08-22 10:54:31'),
        (44, 1166, null, null, 1, 2222.00, 2222.00, null, 27, 1, 1, null, null, '2023-08-22 11:42:50', '2023-08-22 11:42:50'),
        (45, 1166, null, null, -1, 2222.00, 0.00, null, 28, 1, 1, '', null, '2023-08-22 11:43:13', '2023-08-22 11:43:13'),
        (46, 1166, null, null, 1, 5000.00, 5000.00, null, 27, 1, 1, null, null, '2023-08-22 11:48:25', '2023-08-22 11:48:25'),
        (47, 4, null, null, 1, 10.00, 10.00, null, 27, 1, 1, null, null, '2023-08-23 02:56:48', '2023-08-23 02:56:48'),
        (48, 4, null, null, -1, 5.00, 5.00, null, 28, 1, 1, '', null, '2023-08-23 02:56:56', '2023-08-23 02:56:56'),
        (49, 4, null, null, 1, 1.00, 6.00, null, 27, 1, 1, null, null, '2023-08-23 03:00:34', '2023-08-23 03:00:34'),
        (50, 1161, null, null, 1, 10.00, 10.00, null, 27, 1, 1, null, null, '2023-08-23 05:18:40', '2023-08-23 05:18:40'),
        (51, 4, null, null, -1, 1.00, 5.00, null, 2, 1, 1, '', null, '2023-08-23 22:36:26', '2023-08-23 22:36:26'),
        (52, 4, null, null, -1, 1.00, 4.00, null, 2, 1, 1, '', null, '2023-08-23 23:43:35', '2023-08-23 23:43:35'),
        (53, 4, null, null, 1, 5.00, 9.00, null, 27, 1, 1, null, null, '2023-08-24 00:28:37', '2023-08-24 00:28:37'),
        (54, 4, null, null, -1, 1.00, 8.00, null, 2, 1, 1, '', null, '2023-08-24 00:29:46', '2023-08-24 00:29:46'),
        (55, 4, null, null, -1, 1.00, 7.00, null, 2, 1, 1, '', null, '2023-08-24 00:31:08', '2023-08-24 00:31:08'),
        (56, 4, null, null, -1, 1.00, 6.00, null, 2, 1, 1, '', null, '2023-08-24 04:15:05', '2023-08-24 04:15:05'),
        (57, 4, null, null, -1, 1.00, 5.00, null, 2, 1, 1, '', null, '2023-08-24 04:17:45', '2023-08-24 04:17:45'),
        (58, 4, null, null, -1, 1.00, 4.00, null, 2, 1, 1, '', null, '2023-08-25 06:36:41', '2023-08-25 06:36:41'),
        (59, 4, null, null, -1, 1.00, 3.00, null, 2, 1, 1, '', null, '2023-08-30 04:41:45', '2023-08-30 04:41:45'),
        (60, 4, null, null, -1, 1.00, 2.00, null, 2, 1, 1, '', null, '2023-08-30 04:41:51', '2023-08-30 04:41:51'),
        (61, 4, null, null, -1, 1.00, 1.00, null, 2, 1, 1, '', null, '2023-08-30 04:52:01', '2023-08-30 04:52:01'),
        (62, 4, null, null, -1, 1.00, 0.00, null, 2, 1, 1, '', null, '2023-08-30 04:52:49', '2023-08-30 04:52:49'),
        (63, 946, null, null, -1, 1.00, 697.00, null, 2, 1, 1, '', null, '2023-08-30 05:10:24', '2023-08-30 05:10:24'),
        (64, 946, null, null, -1, 1.00, 696.00, null, 2, 1, 1, '', null, '2023-08-30 05:10:33', '2023-08-30 05:10:33'),
        (65, 946, null, null, -1, 1.00, 695.00, null, 2, 1, 1, '', null, '2023-08-30 05:10:46', '2023-08-30 05:10:46'),
        (66, 946, null, null, -1, 1.00, 694.00, null, 2, 1, 1, '', null, '2023-08-30 05:10:55', '2023-08-30 05:10:55');
