create table brand
(
    id          bigint auto_increment
        primary key,
    name        varchar(100) null,
    description varchar(250) null,
    country     varchar(100) null,
    create_at   datetime     null,
    update_at   datetime     null,
    created_by  bigint       null,
    update_by   bigint       null,
    status      tinyint(1)   null
)
    comment 'Bảng lưu các thương hiệu sản phẩm';

