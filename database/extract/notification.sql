create table notification
(
    id         bigint auto_increment comment 'Khóa chính, định danh thông báo'
        primary key,
    title      varchar(150) null comment 'Tiêu đề thông báo',
    content    text         null comment 'Nội dung chi tiết',
    created_at datetime     null comment 'Thời gian tạo',
    create_by  bigint       null comment 'ID người tạo',
    update_at  datetime     null comment 'Thời gian cập nhật',
    update_by  bigint       null comment 'ID người cập nhật'
)
    comment 'Bảng lưu thông báo cho người dùng';

