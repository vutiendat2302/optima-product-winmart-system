create table if not exists brand
(
    id          bigint auto_increment
        primary key,
    name        varchar(100) null,
    description varchar(250) null,
    country     varchar(100) null,
    create_at   datetime     null,
    update_at   datetime     null,
    created_by  bigint       null,
    update_by   bigint       null,
    status      tinyint(1)   null
)
    comment 'Bảng lưu các thương hiệu sản phẩm';

create table if not exists category
(
    id           bigint auto_increment
        primary key,
    name         varchar(100) null,
    seo_title    varchar(250) null,
    description  varchar(250) null,
    status       tinyint(1)   null,
    parent_id    bigint       null comment 'Xác định mối quan hệ phân cấp, danh mục cha',
    meta_keyword varchar(100) null comment 'mô tả ngắn',
    create_by    bigint       null,
    create_at    datetime     null,
    update_by    bigint       null,
    update_at    datetime     null,
    small_image  varchar(250) null
)
    comment 'Bảng lưu thông tin các danh mục sản phẩm, hỗ trợ phân cấp danh mục';

create table if not exists manufacturing_location
(
    id          bigint auto_increment
        primary key,
    name        varchar(150) null,
    email       varchar(150) null,
    phone       varchar(15)  null,
    address     varchar(250) null,
    status      tinyint(1)   null,
    description varchar(250) null,
    create_by   bigint       null,
    create_at   datetime     null,
    update_by   bigint       null,
    update_at   datetime     null
)
    comment 'Bảng lưu thông tin các nhà cung cấp sản phẩm';

create table if not exists product
(
    id                        bigint auto_increment
        primary key,
    qr_code                   varchar(250)   null comment 'mã vạch',
    name                      varchar(100)   null,
    seo_title                 varchar(250)   null comment 'tiêu đề',
    description               varchar(250)   null comment 'mô tả sản phẩm',
    status                    tinyint(1)     null comment 'trạng thái còn hoạt động không',
    tag                       varchar(150)   null comment 'tag',
    image                     varchar(250)   null comment 'ảnh đại diên',
    list_image                text           null comment 'ảnh khác',
    price_normal              decimal(12, 3) null comment 'giá vốn',
    price_sell                decimal(12, 3) null comment 'giá bán',
    promotion_price           decimal(12, 3) null comment 'giá khuyến mãi',
    vat                       decimal(4, 3)  null comment 'thuế vat',
    weight                    decimal(5, 3)  null comment 'trọng lượng',
    warranty                  varchar(50)    null comment 'Thời gian bảo hành',
    hot                       datetime       null comment 'thời điểm đánh dấu nối bật',
    view_count                int            null,
    category_id               bigint         null,
    brand_id                  bigint         null,
    manufacturing_location_id bigint         null comment 'nhà cung cấp sản phẩm',
    meta_keyword              varchar(100)   null comment 'key word mô ta để tìm kiếm',
    create_by                 bigint         null,
    create_at                 datetime       null,
    update_by                 bigint         null,
    update_at                 datetime       null,
    expiry_date               varchar(50)    null,
    sellable                  tinyint(1)     null comment 'có được bán trực tiếp hay không',
    suggest_day_minimum_stock datetime       null comment 'gợi ý ngày hết hàng',
    constraint product_ibfk_1
        foreign key (category_id) references category (id),
    constraint product_ibfk_2
        foreign key (brand_id) references brand (id),
    constraint product_ibfk_3
        foreign key (manufacturing_location_id) references manufacturing_location (id)
)
    comment 'Bảng lưu thông tin chi tiết các sản phẩm';

create table if not exists store
(
    id          bigint       not null comment 'Khóa chính, định danh cửa hàng'
        primary key,
    name        varchar(150) null comment 'Tên cửa hàng',
    email       varchar(150) null,
    address     varchar(250) null,
    description varchar(250) null,
    create_by   bigint       null comment 'ID người tạo cửa hàng',
    create_at   datetime     null comment 'Thời gian tạo cửa hàng',
    update_by   bigint       null comment 'ID người cập nhật gần nhất',
    update_at   datetime     null comment 'Thời gian cập nhật gần nhất',
    status      tinyint(1)   null comment 'Trạng thái cửa hàng: true = hoạt động'
)
    comment 'Bảng lưu thông tin các cửa hàng';

create table if not exists supplier
(
    id          bigint auto_increment comment 'Khóa chính, nhà cung cấp'
        primary key,
    name        varchar(150) null,
    email       varchar(150) null,
    address     varchar(150) null,
    description varchar(250) null,
    create_by   bigint       null comment 'ID người tạo',
    create_at   datetime     null comment 'Thời gian tạo',
    update_by   bigint       null comment 'ID người cập nhật',
    update_at   datetime     null comment 'Thời gian cập nhật',
    status      tinyint(1)   null comment 'Trạng thái kho: true = hoạt động'
)
    comment 'Bảng lưu thông tin nhà cung cấp';

create table if not exists warehouse
(
    id          bigint                         not null comment 'Khóa chính, định danh kho'
        primary key,
    name        varchar(150)                   not null comment 'Tên kho',
    email       varchar(150)                   not null comment 'Email liên hệ (nếu có)',
    address     varchar(250)                   not null comment 'Địa chỉ kho',
    description varchar(250)                   null comment 'Mô tả thêm (tùy chọn)',
    type        varchar(150) default 'GENERAL' null comment 'Loại kho: chính, phụ, trả hàng, trung chuyển,...',
    store_id    bigint                         null comment 'FK tới cửa hàng quản lý kho (nếu có)',
    status      tinyint(1)   default 1         null comment 'Trạng thái: TRUE = đang hoạt động, FALSE = ngưng dùng',
    create_by   bigint                         not null comment 'Người tạo kho',
    create_at   datetime                       not null,
    update_by   bigint                         null,
    update_at   datetime                       null,
    constraint warehouse_store_id_fk
        foreign key (store_id) references store (id)
)
    comment 'Bảng quản lý thông tin các kho hàng trong hệ thống';

create table if not exists import_log
(
    id               bigint auto_increment comment 'Khóa chính, định danh phiếu nhập, fk import_product'
        primary key,
    description      varchar(250)   null comment 'mô tả, ghi chú',
    from_supplier_id bigint         null comment 'ID nhà cung cấp (FK supplier)',
    to_warehouse_id  bigint         null comment 'ID kho nhập (FK warehouse)',
    start_time       datetime       null comment 'Thời gian bắt đầu nhập',
    end_time         datetime       null comment 'Thời gian hoàn tất nhập',
    total_amount     decimal(18, 3) null comment 'Tổng giá trị nhập',
    status           tinyint(1)     null comment 'Trạng thái phiếu nhập',
    create_by        bigint         null comment 'ID người tạo phiếu',
    create_at        datetime       null comment 'Thời gian tạo phiếu',
    update_by        bigint         null comment 'ID người cập nhật',
    update_at        datetime       null comment 'Thời gian cập nhật',
    constraint import_log_supplier_id_fk
        foreign key (from_supplier_id) references supplier (id),
    constraint import_log_warehouse_id_fk
        foreign key (to_warehouse_id) references warehouse (id)
)
    comment 'Bảng ghi nhận các phiếu nhập hàng từ nhà cung cấp về kho';

create table if not exists history_pay
(
    id        bigint               not null comment 'Khóa chính, định danh từng lần thanh toán'
        primary key,
    log_id    bigint               not null comment 'Khóa ngoại tới import_log.id',
    time_pay  datetime             null comment 'Thời gian thanh toán',
    method    varchar(250)         null comment 'Phương thức thanh toán: tiền mặt, chuyển khoản, v.v.',
    status    tinyint(1) default 1 null comment 'Trạng thái: TRUE = hoàn tất, FALSE = lỗi hoặc hủy',
    amount    decimal(18, 3)       not null comment 'Số tiền thanh toán',
    create_by bigint               null comment 'Người tạo',
    create_at datetime             null,
    update_by bigint               null comment 'Người cập nhật',
    update_at datetime             null,
    constraint history_pay_import_log_id_fk
        foreign key (log_id) references import_log (id)
)
    comment 'Lịch sử các lần thanh toán cho phiếu nhập hàng';

create table if not exists import_product
(
    id         bigint         not null
        primary key,
    log_id     bigint         not null comment 'Mã phiếu nhập',
    product_id bigint         not null comment 'ID sản phẩm',
    quantity   int            null comment 'Số lượng nhập',
    price      decimal(12, 3) null comment 'Giá nhập/đơn vị',
    note       varchar(250)   null comment 'Ghi chú',
    constraint import_product_import_log_id_fk
        foreign key (log_id) references import_log (id),
    constraint import_product_product_id_fk
        foreign key (product_id) references product (id)
)
    comment 'Chi tiết sản phẩm trong từng phiếu nhập kho';

create table if not exists inventory
(
    id                 bigint              not null
        primary key,
    warehouse_id       bigint              not null,
    product_id         bigint              not null,
    quantity_available int default 0       null comment 'so luong hien co trong kho',
    minimum_quantity   int default 0       null comment 'nguong toi thieu de nhap kho, hoac canh bao ton kho',
    maximum_quantity   int default 1000000 null comment 'nguong toi da de canh bao ton kho',
    status             tinyint(1)          null,
    create_by          bigint              not null,
    create_at          datetime            not null,
    update_at          datetime            null,
    update_by          bigint              null,
    constraint inventory_product_id_fk
        foreign key (product_id) references product (id),
    constraint inventory_warehouse_id_fk
        foreign key (warehouse_id) references warehouse (id)
)
    comment 'bang quan ly ton kho cua cac san pham';

create table if not exists return_log
(
    id                bigint                        not null comment 'Mã phiếu trả hàng'
        primary key,
    from_warehouse_id bigint                        not null comment 'Kho gửi hàng trả (FK tới warehouse)',
    to_supplier_id    bigint                        not null comment 'Nhà cung cấp nhận hàng trả (FK tới supplier)',
    reason            varchar(250)                  null comment 'Lý do trả hàng',
    return_date       datetime                      not null comment 'Ngày thực hiện trả hàng',
    total_refund      decimal(12, 3)                not null comment 'Tổng tiền hoàn trả',
    status            varchar(50) default 'PENDING' null comment 'Trạng thái: PENDING, COMPLETED, CANCELLED',
    create_by         bigint                        null,
    create_at         datetime                      null,
    update_by         bigint                        null,
    update_at         datetime                      null,
    constraint return_log_supplier_id_fk
        foreign key (to_supplier_id) references supplier (id),
    constraint return_log_warehouse_id_fk
        foreign key (from_warehouse_id) references warehouse (id)
)
    comment 'Phiếu trả hàng cho nhà cung cấp';

create table if not exists return_product
(
    id            bigint         not null comment 'id'
        primary key,
    return_log_id bigint         not null comment 'fk toi return_log',
    product_id    bigint         not null comment 'fk toi product id',
    quantity      int            not null comment 'so luong tra',
    unit_price    decimal(18, 3) not null comment 'don gia khi tra',
    constraint return_product_product_id_fk
        foreign key (product_id) references product (id),
    constraint return_product_return_log_id_fk
        foreign key (return_log_id) references return_log (id)
)
    comment 'Chi tien san pham duoc tra theo phieu tra hang';

