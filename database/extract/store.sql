create table store
(
    id         bigint auto_increment comment 'Khóa chính, định danh cửa hàng'
        primary key,
    name       varchar(100) null comment 'Tên cửa hàng',
    contact_id bigint       null comment 'ID liên hệ của cửa hàng (FK contact)',
    create_by  bigint       null comment 'ID người tạo cửa hàng',
    create_at  datetime     null comment 'Thời gian tạo cửa hàng',
    update_by  bigint       null comment 'ID người cập nhật gần nhất',
    update_at  datetime     null comment 'Thời gian cập nhật gần nhất',
    status     tinyint(1)   null comment 'Trạng thái cửa hàng: true = hoạt động',
    manager_id bigint       null comment 'ID quản lý cửa hàng (liên kết user)',
    constraint store_ibfk_1
        foreign key (contact_id) references contact (id)
)
    comment 'Bảng lưu thông tin các cửa hàng';

create index contact_id
    on store (contact_id);

