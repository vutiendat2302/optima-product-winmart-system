create table import_log
(
    id             bigint auto_increment comment 'Khóa chính, định danh phiếu nhập'
        primary key,
    code_id        bigint         null comment 'Mã phiếu nhập (để join import_product)',
    from_inventory bigint         null comment 'ID kho xuất (FK inventory)',
    to_stock_store bigint         null comment 'ID cửa hàng nhập (FK stock_store)',
    start          datetime       null comment 'Thời gian bắt đầu nhập',
    end            datetime       null comment 'Thời gian hoàn tất nhập',
    total_amount   decimal(18, 3) null comment 'Tổng giá trị nhập',
    status         tinyint(1)     null comment 'Trạng thái phiếu nhập',
    create_by      bigint         null comment 'ID người tạo phiếu',
    create_at      datetime       null comment 'Thời gian tạo phiếu',
    update_by      bigint         null comment 'ID người cập nhật',
    update_at      datetime       null comment 'Thời gian cập nhật',
    constraint import_log_pk
        unique (code_id),
    constraint import_log_ibfk_1
        foreign key (from_inventory) references inventory (id),
    constraint import_log_ibfk_2
        foreign key (to_stock_store) references stock_store (id)
)
    comment 'Bảng ghi nhận các phiếu nhập hàng từ kho về cửa hàng';

create index from_inventory
    on import_log (from_inventory);

create index to_stock_store
    on import_log (to_stock_store);

