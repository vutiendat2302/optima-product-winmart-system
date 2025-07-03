create table payment
(
    id        bigint auto_increment comment 'Khóa chính, định danh phiếu thanh toán'
        primary key,
    name      varchar(150) null comment 'Tên phiếu thanh toán',
    code      varchar(150) null comment 'Mã (ví dụ mã giao dịch ngân hàng)',
    status    tinyint(1)   null comment 'Trạng thái thanh toán: true = hoàn thành, false = lỗi',
    method_id bigint       null comment 'ID phương thức thanh toán (FK payment_method)',
    time      datetime     null comment 'Thời điểm thanh toán',
    create_by bigint       null comment 'ID người tạo',
    create_at datetime     null comment 'Thời gian tạo',
    update_by bigint       null comment 'ID người cập nhật',
    update_at datetime     null comment 'Thời gian cập nhật',
    constraint payment_ibfk_1
        foreign key (method_id) references payment_method (id)
)
    comment 'Bảng lưu thông tin phiếu thanh toán';

create index method_id
    on payment (method_id);

