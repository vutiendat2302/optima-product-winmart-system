create table import_product
(
    code_id    bigint         not null comment 'Mã phiếu nhập (FK import_log)',
    product_id bigint         not null comment 'ID sản phẩm',
    quantity   int            null comment 'Số lượng nhập',
    price      decimal(12, 3) null comment 'Giá nhập/đơn vị',
    note       varchar(250)   null comment 'Ghi chú',
    id         bigint         not null
        primary key,
    constraint import_product_pk
        unique (code_id, product_id),
    constraint import_product_ibfk_1
        foreign key (code_id) references import_log (code_id),
    constraint import_product_ibfk_2
        foreign key (product_id) references product (id)
)
    comment 'Chi tiết sản phẩm trong từng phiếu nhập kho';

create index product_id
    on import_product (product_id);

