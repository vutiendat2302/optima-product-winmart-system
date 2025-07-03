create table vocher
(
    id           bigint auto_increment comment 'Khóa chính, định danh voucher'
        primary key,
    name         varchar(150)  null comment 'Tên voucher',
    seo_title    varchar(250)  null comment 'Tiêu đề SEO',
    description  varchar(250)  null comment 'Mô tả voucher',
    status       tinyint(1)    null comment 'Trạng thái voucher: true = hoạt động',
    start        datetime      null comment 'Thời gian bắt đầu hiệu lực',
    end          datetime      null comment 'Thời gian hết hạn',
    discount     decimal(5, 3) null comment 'Số tiền/giá trị giảm',
    discount_per varchar(10)   null comment 'Kiểu giảm giá: phần trăm hoặc số tiền',
    create_by    bigint        null comment 'ID người tạo',
    create_at    datetime      null comment 'Thời gian tạo',
    update_by    bigint        null comment 'ID người cập nhật',
    update_at    datetime      null comment 'Thời gian cập nhật'
)
    comment 'Bảng lưu thông tin các voucher (phiếu giảm giá)';

