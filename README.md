# WinMart SmartStore Suite 
<!-- Một công cụ thông minh cho chuỗi cửa hàng -->

# A. Project Overview:
WinMart is a supermarket chain establisher by Vingroup, a leading conglomerate in VietNam. 

### Objectives:
- Manage sales operations (employees, products, inventory, customer information, transaction history).
- Analyze retail chain data (revenue, inventory levels, best-selling/slow-moving products, promotion/voucher effectiveness, employee performance, customer ordering behavior).
- Forecast demand and revenue to optimize business decisions.

# B. Functionality: 


## 1. High Level Design:

``` mermaid
    flowchart BT
        subgraph frontend
            FE[frontend]
        end
        subgraph backend
            BE[backend]
            FM[forecast] <--> BE
            MN[manager] <--> BE
            DB[database_mysql] <--> BE
            SC[schedule] <--> BE
        end
        BE <--> FE
        
```



## 2. User Roles:

- admin
- manager
- staff
- analyst

|User Roles              | Task                                                            |
|-----------------------|-------------------------------------------------------------------------|
| admin        | Quản lý toàn bộ hệ thống, CRUD, phân quyền |    |
| manager    | Quản lý cửa hàng, sản phẩm, kho, lịch, nhân viên, xem báo cáo |
| staff         | Nhân viên bình thường (bán hàng, thủ kho, thu ngân, ...). Thực hiện xem lịch, nhập thông tin khách hàng  |
| analyst       | Phân tích dữ liệu, dự báo. Xem, lấy dữ liệu, xuất báo cáo.    |



### Use Case Diagram:
``` mermaid
graph LR
    SA[admin] --> R1[Quản lý hệ thống]
    SA --> R3[CRUD mọi dữ liệu]
    SA --> R4[Phân quyền]
    SA --> M2_1[Quản lý lịch làm việc]
    SA --> M2_2[Quản lý thông tin users]


    RM[manager] --> R6[CRU cửa hàng mình quản lý]
    RM --> R7[CRUD nhân viên thuộc cửa hàng]
    RM --> R8[Lên lịch, duyệt lịch cho nhân viên cửa hàng]
    RM --> M3[Xem báo cáo danh số, lịch làm việc] 


    AM[staff] --> R9[R với dữ liệu cá nhân]
    AM --> R10[Xem lịch làm việc, xác nhận ca làm]
    AM --> R11[Tạo đơn bán hàng, nếu là thu ngân / nhân viên bán hàng]
    AM --> R11_1[Cập nhật hàng tồn kho, nếu là nhân viên kho]
  

    SM[analyst] --> R12[Xem dữ liệu đơn hàng, tồn kho, doanh số]
    SM --> R13[Lấy lịch sử dữ liệu bán hàng]
    SM --> R14[Xem kết quả, in kết quả]

```

## 3. Sequence Dagram:

### Đăng nhập & xác thực người dùng:

``` mermaid
sequenceDiagram
    participant FE as Frontend
    participant BE as Backend
    participant DB as Database

    FE->>BE: Gửi thông tin đăng nhập (username, password)
    BE->>DB: Truy vấn user, kiểm tra thông tin đăng nhập
    DB-->>BE: Trả về kết quả xác thực (thành công/thất bại, role)
    BE-->>FE: Trả kết quả (token, thông tin user)
```

### super-admin: 
``` mermaid
sequenceDiagram
    
```

### managers:
``` mermaid
sequenceDiagram 
    
```


### accountant:
``` mermaid
sequenceDiagram 
   

```
### staffs:
``` mermaid


```
### support & marketing
``` mermaid


```

## 5. State Diagram:

### Login Diagram:

``` mermaid
stateDiagram-v2
    [*] --> enter_information
    enter_information --> check_information
    check_information --> true
    check_information --> false
    false --> enter_information : try_again
    true --> success
    success --> [*]
```

### Information Diagram:

``` mermaid
stateDiagram-v2
    [*] --> login
    login --> no_information
    login --> information
    information --> [*] : save
    information --> update
    no_information --> update
    no_information --> [*] : save
    update --> [*] : save
```

### Report Diagram:

``` mermaid
stateDiagram-v2
    [*] --> login
    login --> choose_report
    choose_report --> show_report
    show_report --> [*] : no_print
    show_report --> print
    print --> [*] : print_success
```

### Pos-Cashier Diagram:

``` mermaid
stateDiagram-v2
    cashier --> tiep_nhan_yeu_cau_thanh_toan_hoa_don
    tiep_nhan_yeu_cau_thanh_toan_hoa_don --> tinh_tong_gia_tri_don_hang : hang_co_ma_vach
    tiep_nhan_yeu_cau_thanh_toan_hoa_don --> manager : hang_khong_co_ma_vach
    tinh_tong_gia_tri_don_hang --> in_hoa_don : luu_hoa_don
    tinh_tong_gia_tri_don_hang --> thanh_toan
    manager --> cap_nhat_thong_tin
    in_hoa_don --> [*]
    thanh_toan --> [*]
    cap_nhat_thong_tin --> [*]
```


## 6. Moudel Description: 

### a. forecast-model:
- Function: Dự đoán doanh thu, nhu cầu hàng hóa dựa trên dữ liệu lịch sử bán hàng. 

- Input: Dữ liệu lịch sử đơn hàng, dữ liệu kho, dữ liệu khách hàng.

- Output: Kết quả dự đoán. 

- Related Modules: database, inventory-management-model, schedule-model.

### b. store-management-model:
- Function: Quản lý thông tin cửa hàng (tên, địa chỉ, liên hệ, doanh thu), trạng thái hoạt động và người quản lý.

- Input: Thông tin từ người dùng hoặc hệ thống.

- Output: Danh sách cửa hàng, báo cáo doanh thu.

- Related Modules: database, inventory-management-model, user-role.
### c. employee-management-model:
- Function: Quản lý nhân viên (thêm, sửa, phân quyền, phân công).

- Input: Dữ liệu nhân viên, thông tin phân quyền từ user-role.

- Output: Danh sách nhân viên theo từng cửa hàng, vai trò cụ thể.

- Related Modules: database, user-role.
### d. customer-management-model:
- Function: Quản lý thông tin khách hàng và lịch sử mua hàng.

- Input: Thông tin đăng ký, dữ liệu đơn hàng.

- Output: Danh sách khách hàng, thống kê hành vi mua sắm.

- Related Modules: database, order (online/offline), feedback.
### e. inventory-management-model:
- Function: Theo dõi tình trạng hàng tồn, nhập hàng, phân phối hàng hóa từ kho đến cửa hàng.

- Input: Dữ liệu sản phẩm, phiếu nhập kho, dữ liệu từ import_log, import_product.

- Output: Số lượng tồn kho, cảnh báo thiếu hàng.

- Related Modules: database, product, store-management-model.
### f. schedule-model:
- Function: Lịch nhập hàng, lịch khuyến mãi hoặc sự kiện. Lên lịch vận chuyển hàng hóa tự động. Lên lịch làm việc cho nhân viên (tự động sắp xếp lại lịch làm việc khi có sự thay đổi về nhân lực).

- Input: Lịch từ quản lý, lịch sử làm việc, thông tin nhân viên.

- Output: Bảng phân công lịch theo ngày/tuần/tháng.

- Related Modules: employee-management-model, inventory-management-model.

### g. user-role:
- Function: Quản lý phân quyền người dùng, xác định ai được làm gì trong hệ thống.

- Input: Dữ liệu đăng nhập, vai trò được cấp bởi admin.

- Output: Quyền truy cập từng module, luồng xử lý.

- Related Modules: employee-management-model, store-management-model, schedule-model.

 ## 7. Technology:

> backend: framework: string boot, node.js

> frontend: react.js, javascript

> database: mysql

> cloud: aws-s3

> deploy: 

> forecasting: ml model,

> others: git, git hub