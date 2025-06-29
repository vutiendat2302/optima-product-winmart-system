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
            W1[web/admin ui]
            W1 <--> FE
        end

        subgraph backend
            BE[backend]
            FM[forecast] <--> SM
            SM[module]
            UR[user-role] <--> SM
            SMH[store-management] <--> SM
            EMH[employee-management] <--> SM
            CMH[customer-management] <--> SM
            WMH[inventory-management] <--> SM
            SC[schedule] <--> SM
            DB[database]
            SV[aws-s3] <--> SM
        end

        BE <--> FE
        SM <--> BE
        DB <--> BE
        
```



## 2. User Roles:

- super-admin
- regional-manager
- area-manager
- store-manager
- inventory-manager
- warehouse-staff
- pos-cashier
- accountant
- customer-support
- marketing-officer

|User Roles              | Task                                                            |
|-----------------------|-------------------------------------------------------------------------|
| super-admin           | Quản lý toàn bộ hệ thống, cấp quyền truy cập, giám sát và bảo trì.      |
| regional-manager      | Quản lý các khu vực, điều phối giữa các chi nhánh khu vực và báo cáo.   |
| area-manager          | Giám sát các cửa hàng trong khu vực, báo cáo.     |
| store-manager         | Quản lý hoạt động hàng ngày của cửa hàng, nhân viên và doanh thu.       |
| inventory-manager     | Quản lý kho theo khu vực, thống kê, báo cáo.            |
| warehouse-staff       | Thực hiện nhập kho, xuất kho, sắp xếp và kiểm tra hàng hóa.             |
| pos-cashier           | Xử lý giao dịch tại quầy, quản lý thanh toán và hỗ trợ khách hàng.      |
| accountant            | Quản lý tài chính, lập báo cáo thu chi và kiểm toán.                    |
| customer-support      | Hỗ trợ khách hàng, xử lý khiếu nại và cung cấp thông tin dịch vụ.       |
| marketing-officer     | Lên kế hoạch quảng cáo, tiếp thị sản phẩm và xây dựng chiến lược thương hiệu. |

### Diagram Roles:

``` mermaid
graph TD
     SA[Super Admin]
    RM[Regional Manager]
    AM[Area Manager]
    SM[Store Manager]
    IM[Inventory Manager]
    SS[Warehouse Staff]
    PC[POS Cashier]
    AC[Accountant]
    MO[Marketing Officer]
    CS[Support Staff]

    SA --> RM
    SA --> AC
    AC --> AM
    RM --> AM
    AM --> SM
    SM --> PC
    SM --> CS
    SM --> MO
    AM --> IM
    IM --> SS
```

### Use Case Diagram:
``` mermaid
graph LR
    SA[super_admin] --> R1[Quản lý hệ thống]
    SA --> R3[Xem báo cáo toàn chuỗi, vùng, cửa hàng]
    SA --> R4[Phân quyền] --> ADD[Thêm, sửa, xóa, update quản lý, nhân viên]
    SA --> M1[Quản lý cửa hàng] --> M1_1[Thêm, sửa, xóa, update cửa hàng, danh mục]
    SA --> M2[Quản lý  kho]
    SA --> M2_1[Quản lý lịch làm việc]
    SA --> M2_2[Quản lý thông tin users]
    SA --> M2_3[Quản lý vocher, chiến dịch quảng cáo]

    RM[regional_manager] --> R6[Xem báo cáo vùng]
    RM --> R7[Quản lý Area Manager]
    RM --> R8[Phê duyệt tồn kho vùng, theo dõi hàng tồn kho]
    RM --> M3[Quản lý nhân viên] --> M3_1[Thêm, sửa, xóa, update nhân viên]
    RM --> M3_2[Quản lý lịch làm việc của nhân viên]
    RM --> M3_3[Quản lý doanh thu của cửa hàng theo vùng]

    AM[area_manager] --> R9[Quản lý cửa hàng khu vực]
    AM --> R10[Theo dõi tồn kho]
    AM --> R11[Quản lý lịch làm việc của nhân viên]
    AM --> R11_1[Quản lý doanh thu của cửa hàng theo khu vực]
    AM --> R11_2[Quản lý nhân viên cửa hàng theo khu vực]

    SM[store_manager] --> R12[Quản lý kho cửa hàng]
    SM --> R13[Quản lý nhân viên cửa hàng]
    SM --> R14[Xem doanh thu cửa hàng, lịch sử giao dịch của cửa hàng]
    SM --> R14_1[Quản lý vocher, chiến dịch quảng cáo]

    IM[inventory_manager] --> R15[Điều phối hàng hóa]
    IM --> R16[Kiểm kê kho]
    IM --> R16_1[Quản lý lịch vận chuyển]

    SS[warehouse_taff] --> R17[Nhập hàng]
    SS --> R18[Xuất hàng]
    SS --> R18_1[Kiểm kê hàng]

    PC[pos_cashier] --> R19[Tạo hóa đơn]
    PC --> R20[Bán hàng tại quầy]
    PC --> R21[Nhập thông tin khách hàng]

    AC[accountant] --> R21[Xem báo cáo tài chính]
    AC --> R22[Kiểm soát dòng tiền]
    AC --> R22_1[Kiểm toán]
    AC --> R22_2[Quản lý voucher, chiến dịch quảng cáo]

    CS[support_staff] --> R23[Trả lời khách hàng]
    CS --> R24[Tra cứu đơn hàng]
    CS --> R23_1[Xem thông tin khách hàng]
    CS --> R23_2[Nhập thông tin khách hàng]

    MO[marketing_officer] --> R25[Tạo voucher]
    MO --> R26[Tạo chiến dịch quảng cáo]

```

### Use Case Overview:
``` mermaid
graph TB

    %% Actor
    super_admin([super_admin])
    regional_manager([regional_manager])
    area_manager([area_manager])
    store_manager([store_manager])
    inventory_manager([inventory_manager])
    warehouse_staff([warehouse_staff])
    pos_cashier([pos_cashier])
    accountant([accountant])
    support_staff([support_staff])
    marketing_officer([marketing_officer])

    %% Use cases (elipses)
    uc1((quản lý hệ thống))
    uc2((xem báo cáo))
    uc3((phân quyền))
    uc4((quản lý cửa hàng, danh mục))
    uc5((quản lý kho))
    uc6((quản lý lịch làm việc))
    uc7((quản lý nhân viên))
    uc8((tạo voucher, quảng cáo))
    uc9((tạo hóa đơn))
    uc10((bán hàng tại quầy))
    uc11((nhập thông tin khách hàng))
    uc12((nhập hàng))
    uc13((xuất hàng))
    uc14((kiểm kê hàng))
    uc15((kiểm toán))
    uc16((chăm sóc khách hàng))
    uc17((tra cứu đơn hàng))

    %% Mối quan hệ
    super_admin --> uc1
    super_admin --> uc2
    super_admin --> uc3
    super_admin --> uc4
    super_admin --> uc5
    super_admin --> uc6
    super_admin --> uc7
    super_admin --> uc8

    regional_manager --> uc2
    regional_manager --> uc5
    regional_manager --> uc6
    regional_manager --> uc7

    area_manager --> uc2
    area_manager --> uc5
    area_manager --> uc6
    area_manager --> uc7

    store_manager --> uc2
    store_manager --> uc5
    store_manager --> uc6
    store_manager --> uc7
    store_manager --> uc8

    inventory_manager --> uc5
    inventory_manager --> uc12
    inventory_manager --> uc13
    inventory_manager --> uc14

    warehouse_staff --> uc12
    warehouse_staff --> uc13
    warehouse_staff --> uc14

    pos_cashier --> uc9
    pos_cashier --> uc10
    pos_cashier --> uc11

    accountant --> uc2
    accountant --> uc15

    support_staff --> uc16
    support_staff --> uc17
    support_staff --> uc11

    marketing_officer --> uc8

```

## 3. ERD:
``` mermaid 
erDiagram
    store ||--o{ analyst : analyzes
    inventory ||--o{ analyst : analyzes
    inventory ||--o{ import_log : analyzes
    store ||--o{ import_log : analyzes
    product ||--o{ store : stored_in
    user ||--o{ analyst : creates
    customer ||--o{ store : order

```

## 4. Sequence Dagram:

### models:

``` mermaid
sequenceDiagram
    participant backend
    participant store-management
    participant employee-management
    participant customer-management
    participant inventory-management
    participant user-role
    participant schedule
    participant forecast
    participant database
    participant aws-s3

    %% Đăng nhập và kiểm tra phân quyền
    backend->>user-role: kiểm tra, thêm, sửa, xóa quyền truy cập
    user-role->>database: truy vấn vai trò người dùng, ghi dữ liệu 
    database-->>user-role: trả về thông tin role
    user-role-->>backend: role result

    %% Quản lý cửa hàng
    backend->>store-management: thêm, sửa, xóa cửa hàng
    backend ->> store-management: truy suất thông tin cửa hàng, nhân viên, doanh thu
    store-management->>database: ghi dữ liệu cửa hàng
    store-management->>database: truy suất thông tin
    database-->>store-management: result
    store-management-->> backend: store reuslt
    database-->>store-management: xác nhận
    store-management-->>backend: OK

    %% Quản lý nhân sự
    backend->>employee-management: thêm, sửa, xóa user
    employee-management->>database: cập nhật thông tin nhân sự
    database-->>employee-management: result
    employee-management--> backend: result employee

    %% Quản lý khách hàng
    backend->>customer-management: cập nhật khách hàng, lấy thông tin khách hàng
    customer-management->>database: truy suất thông tin khách hàng
    database-->> customer-management: thông tin khách hàng
    customer-management -->> backend: result customer

    %% Quản lý kho
    backend->>inventory-management: xử lý nhập/xuất/kiểm kê kho
    inventory-management->>database: cập nhật tồn kho
    database-->> inventory-management: thông tin kho
    inventory-management -->> backend: result inventory

    %% Lịch làm việc
    backend->>schedule: tạo hoặc chỉnh sửa lịch làm việc
    schedule->>database: lưu dữ liệu ca làm
    schedule->>schedule: auto create schedule
    schedule -->> backend: schedule result

    %% Dự báo
    backend->>forecast: yêu cầu dự báo hàng hóa
    forecast->>database: lấy dữ liệu lịch sử
    forecast->>aws-s3: lấy model ML hoặc dữ liệu phụ trợ
    aws-s3-->>forecast: model/data
    forecast-->>backend: kết quả dự báo

    database ->> aws-s3: update data to cloud
```

### super-admin: 
``` mermaid
sequenceDiagram
    participant super-admin
    participant system
    participant store-management
    participant employee-management
    participant customer-management
    participant inventory-management
    participant user-role
    participant schedule
    participant forecast
    participant database
    participant aws-s3

    %% start use case
    super-admin->>system: đăng nhập hệ thống
    system->>database: xác thực thông tin

    database-->>system: trả kết quả xác thực
    system-->>super-admin: xác thực thành công

    %% Quản lý cửa hàng
    super-admin->>system: thêm, sửa, xóa cửa hàng mới
    system->>store-management: xử lý yêu cầu
    store-management->>database: ghi thông tin cửa hàng
    database-->>store-management: xác nhận
    store-management-->>system: thành công
    system-->>super-admin: thêm, sửa, xóa cửa hàng thành công

    %% Quản lý nhân viên
    super-admin->>system: thêm, sửa, xóa nhân viên, quản lý
    super-admin ->> system: thêm, sửa, xóa user-role của nhân viên, quản lý
    system->>employee-management: xử lý thêm user
    system ->> user-role: xử lý yên cầu
    employee-management->>database: lưu thông tin nhân viên, quản lý
    user-role -> database: lưu thông tin
    database -->> user-role: Ok
    database-->>employee-management: OK
    system -->> super-admin: kết quả

    %% Quản lý khách hàng
    super-admin->>system: cập nhật thông tin khách hàng
    system->>customer-management: gửi yêu cầu
    customer-management->>database: cập nhật data


    %% Quản lý kho
    super-admin->>inventory-management: kiểm tra tồn kho,  truy xuất dữ liệu
    inventory-management->>database: truy vấn dữ liệu kho
    database-->> inventory-management: result inventory
    inventory-management-->>system: result inventory
    system-->>super-admin: hiện kết quả

    %% Quản lý lịch làm việc
    super-admin->>schedule: cập nhật, xem lịch làm việc
    schedule->>database: ghi thông tin lịch
    schedule->>schedule: tạo lịch làm việc cho nhân viên
    database-->> system: schedule result
    system-->> super-admin: hiện kết quả schedule

    %% Dự báo hàng tồn
    super-admin->>forecast: yêu cầu dự báo hàng hóa
    forecast->>database: truy xuất dữ liệu lịch sử
    forecast->>aws-s3: lấy dữ liệu học máy
    aws-s3-->>forecast: trả mô hình
    forecast-->>super-admin: gửi kết quả dự báo

    database->> aws-s3: save data
    aws-s3->> database: result data
```

### managers:
``` mermaid
sequenceDiagram 
    participant regional-manager
    participant area-manager
    participant store-manager
    
    participant system
    participant store-management
    participant employee-management
    participant customer-management
    participant inventory-management
    participant schedule
    participant forecast
    participant database

    %% regional_manager xem báo cáo vùng
    regional-manager->>system: yêu cầu báo cáo vùng
    system->>inventory-management: truy xuất dữ liệu kho theo vùng
    inventory-management->>database: query tồn kho vùng
    database-->>inventory-management: dữ liệu tồn kho
    inventory-management-->>system: dữ liệu đã xử lý
    system-->>regional-manager: hiển thị báo cáo vùng

    %% area_manager gửi yêu cầu điều phối hàng lên regional_manager
    area-manager->>system: gửi yêu cầu 
    system-->>regional-manager: phê duyệt yêu cầu
    regional-manager-->> system: kết quả 
    system-->>area-manager: hiển thị kết quả

    %% area-manager cập nhật lịch làm việc nhân viên
    area-manager->>system: cập nhật lịch làm việc nhân viên, xem lịch làm việc
    system->>schedule: gửi thông tin ca làm
    schedule->>database: lưu lịch làm việc
    database-->>schedule: xác nhận
    schedule-->>system: OK
    system-->>area_manager: cập nhật thành công, hiển thị lịch làm việc

    %% store_manager xem danh sách nhân viên
    store-manager->>system: yêu cầu danh sách nhân viên cửa hàng
    system->>employee-management: query nhân viên theo cửa hàng
    employee-management->>database: lấy dữ liệu nhân viên
    database-->>employee-management: danh sách nhân viên
    employee-management-->>system: trả dữ liệu
    system-->>store-manager: hiển thị danh sách

    store-manager ->> system: xem lịch làm việc
    system ->>schedule: truy xuất lịch làm việc của cửa hàng
    schedule ->> database: lấy thông tin lịch làm việc
    database -->> system: thông tin lịch làm việc
    system -->> store-manager: hiển thị thông tin lịch làm việc

    %% store_manager 
    store-manager->>system: lấy thông tin sản phẩm, thông tin của cửa hàng
    system->>database: xử lý yêu cầu
    database-->>system: thông tin cửa hàng, sản phẩm
    system-->>store-manager: hiển thị thông tin sản phẩm ,cửa hàng

    %% store_manager yêu cầu dự báo tồn kho, sản phẩm bán chạy
    store-manager->>forecast: gửi yêu cầu dự báo hàng
    forecast->>database: lấy dữ liệu lịch sử
    database-->>forecast: dữ liệu quá khứ
    forecast-->>store-manager: kết quả dự báo
```


### accountant:
``` mermaid
sequenceDiagram 
    participant accountant
    
    participant system
    participant store-management
    participant employee-management
    participant customer-management
    participant inventory-management
    participant schedule
    participant forecast
    participant database

    %% accountant xem báo cáo tài chính
    accountant->>system: yêu cầu báo cáo tài chính
    system->>inventory-management: lấy thông tin xuất, nhập hàng, kiểm xoát doanh thu
    system->> forecast: tổng hợp dữ liệu doanh thu, chi phí, dự đoán doanh thu, phát triển
    inventory-management->>database: truy vấn hóa đơn, nhập-xuất
    forecast ->> database: truy vấn dữ liệu doanh thu
    forecast ->> aws-s3: lấy dữ liệu để tạo mô hình học máy
    database-->> forecast: dữ liệu doanh thu
    aws-s3 -->> forecast: dữ liệu doanh thu
    forecast -->> system: tổng hợp báo cáo tài chính, dự đoán
    database-->>inventory-management: dữ liệu hàng hóa
    inventory-management-->>system: tổng hợp báo cáo tình hình hàng hóa trong các kho
    system-->>accountant: hiển thị báo cáo tài chính

    %% accountant kiểm toán dòng tiền
    accountant->>system: kiểm toán dòng tiền
    system->>database: truy xuất lịch sử giao dịch
    database-->>system: dữ liệu đầy đủ
    system-->>accountant: kết quả kiểm toán

    %% accountant xem thông tin nhân viên cửa hàng
    accountant->>employee-management: xem thông tin lương, ca làm
    employee-management->>database: truy vấn bảng chấm công
    database-->>employee-management: dữ liệu nhân sự
    employee-management-->>accountant: hiển thị thông tin

```
### staffs:
``` mermaid
sequenceDiagram 
    participant inventory
    participant warehouse-staff
    participant pos-cashier

    
    participant system
    participant store-management
    participant employee-management
    participant customer-management
    participant inventory-management
    participant schedule
    participant forecast
    participant database

     %% inventory-manager tạo kế hoạch nhập hàng, xuất hàng
    inventory->>system: lên kế hoạch nhập hàng, xuất hàng
    system->>inventory-management: tạo phiếu nhập, phiếu xuất
    inventory-management->>database: ghi dữ liệu kế hoạch
    database-->>inventory-management: OK
    inventory-management-->>system: thành công
    system-->>inventory: hiển thị xác nhận

    %% warehouse-staff thực hiện nhập hàng
    warehouse-staff->>inventory-management: nhập hàng thực tế
    inventory-management->>database: cập nhật kho
    database-->>inventory-management: đã cập nhật
    inventory-management-->>warehouse-staff: xác nhận nhập

    %% warehouse-staff thực hiện xuất hàng
    warehouse-staff->>inventory-management: xuất hàng theo phiếu
    inventory-management->>database: giảm tồn kho
    database-->>inventory-management: OK

    %% pos-cashier tạo hóa đơn bán lẻ
    pos-cashier->>system: tạo hóa đơn
    system->>customer-management: nhập thông tin khách hàng
    customer-management->>database: lưu thông tin KH
    database-->>customer-management: OK
    system->>inventory-management: kiểm tra tồn kho
    inventory-management->>database: xác nhận hàng còn
    database-->>inventory-management: OK
    system-->>pos-cashier: tạo hóa đơn thành công
    system-->>database: lưu hóa đơn

```
### support & marketing
``` mermaid
sequenceDiagram 
    participant support-staff
    participant marketing-officer
    
    participant system
    participant store-management
    participant employee-management
    participant customer-management
    participant inventory-management
    participant schedule
    participant forecast
    participant database

     %% support-staff tra cứu đơn hàng
    support-staff->>system: tra cứu đơn hàng
    system->>customer-management: tìm thông tin đơn
    customer-management->>database: query đơn hàng
    database-->>customer-management: trả kết quả
    customer-management-->>support-staff: thông tin đơn hàng

    %% support-staff trả lời khách hàng
    support-staff->>customer-management: cập nhật trạng thái hỗ trợ
    customer-management->>database: ghi log hỗ trợ
    database-->>customer-management: xác nhận

    %% marketing-officer tạo chiến dịch quảng cáo
    marketing-officer->>system: tạo chiến dịch quảng cáo
    system->>database: lưu nội dung chiến dịch
    database-->>system: OK
    system-->>marketing-officer: chiến dịch đã tạo

    %% marketing-officer tạo voucher
    marketing-officer->>system: tạo voucher mới
    system->>database: lưu mã voucher
    database-->>system: OK

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

> backend: 
