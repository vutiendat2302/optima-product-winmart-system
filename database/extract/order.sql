create table `order`
(
    id          bigint auto_increment comment 'Khóa chính, định danh đơn hàng'
        primary key,
    date        datetime      null comment 'Thời điểm tạo đơn hàng',
    status      tinyint(1)    null comment 'Trạng thái đơn hàng (true = thành công, false = huỷ)',
    start       datetime      null comment 'Thời điểm bắt đầu xử lý đơn',
    end         datetime      null comment 'Thời điểm hoàn tất đơn',
    customer_id bigint        null comment 'ID khách hàng (FK customer)',
    discount    decimal(5, 3) null comment 'Giá trị giảm giá trực tiếp',
    store_id    bigint        null comment 'ID cửa hàng bán đơn này (FK store)',
    vocher_id   bigint        null comment 'ID voucher áp dụng (FK vocher)',
    pay_id      bigint        null comment 'ID phiếu thanh toán (FK payment)',
    create_by   bigint        null comment 'ID người tạo đơn hàng',
    create_at   datetime      null comment 'Thời gian tạo đơn',
    update_by   bigint        null comment 'ID người cập nhật',
    update_at   datetime      null comment 'Thời gian cập nhật',
    constraint order_ibfk_1
        foreign key (customer_id) references customer (id),
    constraint order_ibfk_2
        foreign key (store_id) references store (id),
    constraint order_ibfk_3
        foreign key (vocher_id) references vocher (id),
    constraint order_ibfk_4
        foreign key (pay_id) references payment (id)
)
    comment 'Bảng lưu thông tin các đơn hàng bán ra';

create index customer_id
    on `order` (customer_id);

create index pay_id
    on `order` (pay_id);

create index store_id
    on `order` (store_id);

create index vocher_id
    on `order` (vocher_id);

