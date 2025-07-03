create table category
(
    id           bigint auto_increment
        primary key,
    name         varchar(100) null,
    seo_title    varchar(250) null,
    description  varchar(250) null,
    status       tinyint(1)   null,
    parent_id    bigint       null,
    meta_keyword varchar(100) null,
    create_by    bigint       null,
    create_at    datetime     null,
    update_by    bigint       null,
    update_at    datetime     null
)
    comment 'Bảng lưu thông tin các danh mục sản phẩm, hỗ trợ phân cấp danh mục';

