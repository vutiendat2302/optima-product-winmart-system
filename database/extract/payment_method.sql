create table payment_method
(
    id          bigint auto_increment comment 'Khóa chính, định danh phương thức thanh toán'
        primary key,
    name        varchar(150)  null comment 'Tên phương thức (tiền mặt, ví điện tử, ...)',
    description varchar(150)  null comment 'Mô tả chi tiết',
    vat         decimal(5, 3) null comment 'Thuế VAT áp dụng cho phương thức này',
    create_by   bigint        null comment 'ID người tạo',
    create_at   datetime      null comment 'Thời gian tạo',
    update_by   bigint        null comment 'ID người cập nhật',
    update_at   datetime      null comment 'Thời gian cập nhật'
)
    comment 'Bảng lưu các phương thức thanh toán';

