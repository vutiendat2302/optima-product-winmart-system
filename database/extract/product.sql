create table product
(
    id              bigint auto_increment
        primary key,
    name            varchar(100)   null,
    seo_title       varchar(250)   null,
    description     varchar(250)   null,
    status          tinyint(1)     null,
    image           varchar(250)   null,
    list_image      text           null,
    price           decimal(12, 3) null,
    promotion_price decimal(12, 3) null,
    vat             decimal(4, 3)  null,
    quantity        int            null,
    waranty         varchar(50)    null,
    hot             datetime       null,
    view_count      int            null,
    cate_id         bigint         null,
    brand_id        bigint         null,
    sup_id          bigint         null,
    meta_keyword    varchar(100)   null,
    create_by       bigint         null,
    create_at       datetime       null,
    update_by       bigint         null,
    update_at       datetime       null,
    expiry_date     varchar(50)    null,
    constraint product_ibfk_1
        foreign key (cate_id) references category (id),
    constraint product_ibfk_2
        foreign key (brand_id) references brand (id),
    constraint product_ibfk_3
        foreign key (sup_id) references supplier (id)
)
    comment 'Bảng lưu thông tin chi tiết các sản phẩm';

create index brand_id
    on product (brand_id);

create index cate_id
    on product (cate_id);

create index sup_id
    on product (sup_id);

