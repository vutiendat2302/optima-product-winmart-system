create table customer
(
    id        bigint auto_increment comment 'Khóa chính, định danh khách hàng'
        primary key,
    username  varchar(250) null comment 'Tên đăng nhập của khách hàng',
    password  varchar(250) null comment 'Mật khẩu đăng nhập (hash)',
    email     varchar(150) null comment 'Địa chỉ email khách hàng',
    phone     varchar(15)  null comment 'Số điện thoại liên hệ',
    status    tinyint(1)   null comment 'Trạng thái tài khoản: true = hoạt động, false = khoá',
    name      varchar(100) null comment 'Họ tên khách hàng',
    gender    tinyint(1)   null comment 'Giới tính: true = nam, false = nữ',
    address   varchar(250) null comment 'Địa chỉ khách hàng',
    create_at datetime     null comment 'Thời gian tạo tài khoản',
    create_by bigint       null comment 'ID người tạo (nếu có)',
    update_by bigint       null comment 'ID người cập nhật gần nhất',
    update_at datetime     null comment 'Thời gian cập nhật gần nhất'
)
    comment 'Bảng lưu thông tin khách hàng';

