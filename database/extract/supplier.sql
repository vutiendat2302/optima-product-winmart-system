create table supplier
(
    id        bigint auto_increment
        primary key,
    name      varchar(100) null,
    email     varchar(150) null,
    phone     varchar(150) null,
    address   varchar(250) null,
    create_by bigint       null,
    create_at datetime     null,
    update_by bigint       null,
    update_at datetime     null
)
    comment 'Bảng lưu thông tin các nhà cung cấp sản phẩm';

