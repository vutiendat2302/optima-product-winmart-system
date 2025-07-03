create table store_revenue
(
    id          bigint auto_increment comment 'Khóa chính, định danh bản ghi doanh thu'
        primary key,
    store_id    bigint         null comment 'ID cửa hàng (FK store)',
    description varchar(250)   null comment 'Mô tả doanh thu',
    date        datetime       null comment 'Ngày thống kê doanh thu',
    revenue     decimal(18, 3) null comment 'Doanh thu (VNĐ)',
    create_by   bigint         null comment 'ID người tạo',
    create_at   datetime       null comment 'Thời gian tạo',
    update_by   bigint         null comment 'ID người cập nhật',
    update_at   datetime       null comment 'Thời gian cập nhật',
    constraint store_revenue_ibfk_1
        foreign key (store_id) references store (id)
)
    comment 'Bảng lưu doanh thu từng cửa hàng';

create index store_id
    on store_revenue (store_id);

