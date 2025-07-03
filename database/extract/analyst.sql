create table analyst
(
    id            bigint auto_increment comment 'Khóa chính, định danh bản ghi phân tích'
        primary key,
    name          varchar(150) null comment 'Tên báo cáo',
    description   varchar(250) null comment 'Mô tả ngắn báo cáo',
    image_analyst varchar(250) null comment 'Ảnh minh họa cho báo cáo',
    detail        varchar(250) null comment 'Nội dung chi tiết báo cáo',
    store_id      bigint       null comment 'ID cửa hàng liên quan (FK store)',
    date_analyst  datetime     null comment 'Ngày phân tích',
    created_at    datetime     null comment 'Thời gian tạo',
    create_by     bigint       null comment 'ID người tạo',
    update_at     datetime     null comment 'Thời gian cập nhật',
    update_by     bigint       null comment 'ID người cập nhật',
    constraint analyst_ibfk_1
        foreign key (store_id) references store (id)
)
    comment 'Bảng lưu các báo cáo phân tích cho từng cửa hàng';

create index store_id
    on analyst (store_id);

