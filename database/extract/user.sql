create table user
(
    id        bigint auto_increment comment 'Khóa chính, định danh người dùng'
        primary key,
    username  varchar(250) null comment 'Tên đăng nhập',
    password  varchar(250) null comment 'Mật khẩu (hash)',
    name      varchar(150) null comment 'Họ tên',
    email     varchar(150) null comment 'Email',
    phone     varchar(15)  null comment 'Số điện thoại',
    status    tinyint(1)   null comment 'Trạng thái tài khoản',
    create_at datetime     null comment 'Thời gian tạo',
    update_by bigint       null comment 'ID người cập nhật',
    update_at datetime     null comment 'Thời gian cập nhật',
    create_by bigint       null comment 'ID người tạo'
)
    comment 'Bảng lưu thông tin người dùng (nhân viên, quản lý, admin, ...)';

