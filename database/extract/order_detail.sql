create table order_detail
(
    id         bigint         not null
        primary key,
    order_id   bigint         null comment 'ID đơn hàng (FK order)',
    product_id bigint         null comment 'ID sản phẩm',
    quantity   int            null comment 'Số lượng bán',
    price      decimal(12, 3) null comment 'Giá bán từng sản phẩm tại thời điểm bán',
    constraint order_detail_pk
        unique (order_id),
    constraint order_id
        unique (product_id),
    constraint order_detail_ibfk_1
        foreign key (order_id) references `order` (id),
    constraint order_detail_ibfk_2
        foreign key (product_id) references product (id)
)
    comment 'Chi tiết sản phẩm trong từng đơn hàng';

