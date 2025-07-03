create table user_activity_log
(
    id          bigint auto_increment comment 'Khóa chính'
        primary key,
    user_id     bigint       null comment 'ID người dùng thực hiện hành động',
    description varchar(250) null comment 'Mô tả chi tiết hành động',
    ip_address  varchar(250) null comment 'Địa chỉ IP thực hiện',
    created_at  datetime     null comment 'Thời gian ghi nhận'
)
    comment 'Bảng lưu nhật ký hoạt động của người dùng';

create index user_id
    on user_activity_log (user_id);

