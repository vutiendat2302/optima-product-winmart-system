create table stock_store
(
    id           bigint auto_increment comment 'Khóa chính, định danh bản ghi tồn kho cửa hàng'
        primary key,
    store_id     bigint     null comment 'ID cửa hàng (FK store)',
    create_by    bigint     null comment 'ID người tạo',
    create_at    datetime   null comment 'Thời gian tạo',
    update_by    bigint     null comment 'ID người cập nhật',
    update_at    datetime   null comment 'Thời gian cập nhật',
    status       tinyint(1) null comment 'Trạng thái: true = hoạt động',
    product_id   bigint     null comment 'ID sản phẩm (FK product)',
    quantity     int        null comment 'Số lượng tồn kho',
    min_quantity int        null comment 'Số lượng tối thiểu cảnh báo tồn kho',
    constraint stock_store_ibfk_1
        foreign key (store_id) references store (id),
    constraint stock_store_ibfk_2
        foreign key (product_id) references product (id)
)
    comment 'Bảng lưu tồn kho sản phẩm tại các cửa hàng';

create index product_id
    on stock_store (product_id);

create index store_id
    on stock_store (store_id);

