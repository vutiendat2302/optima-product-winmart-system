create table contact
(
    id        bigint auto_increment comment 'Khóa chính, định danh liên hệ'
        primary key,
    email     varchar(150) null comment 'Địa chỉ email liên hệ',
    status    tinyint(1)   null comment 'Trạng thái liên hệ: true = hoạt động',
    address   varchar(250) null comment 'Địa chỉ liên hệ',
    phone     varchar(15)  null comment 'Số điện thoại liên hệ',
    create_at datetime     null comment 'Thời gian tạo thông tin liên hệ',
    update_at datetime     null comment 'Thời gian cập nhật liên hệ'
)
    comment 'Bảng lưu thông tin liên hệ';

