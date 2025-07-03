create table role
(
    id          bigint auto_increment comment 'Khóa chính'
        primary key,
    name        varchar(250) null comment 'Tên vai trò',
    type        varchar(250) null comment 'Kiểu role (admin, staff, ...)',
    user_id     bigint       null comment 'ID người dùng (không nên gắn trực tiếp, nên dùng bảng trung gian nếu nhiều-nhiều)',
    description varchar(250) null comment 'Mô tả vai trò',
    created_at  datetime     null comment 'Thời gian tạo',
    update_at   datetime     null comment 'Thời gian cập nhật'
)
    comment 'Bảng lưu các vai trò (role) trong hệ thống';

create index user_id
    on role (user_id);

