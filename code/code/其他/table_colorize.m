try
    Excel = actxGetRunningServer('Excel.Application');
catch
    Excel = actxserver('Excel.Application'); % 创建一个本地Excel服务器
end
 
% Excel.Visible = 1;  % 让打开的Excel可见(默认不可见)

for i = 20:20
    ReadExcel = Excel.Workbooks.Open([pwd,['\增加',num2str(i),'个点.xlsx']]);
    Sheets = Excel.ActiveWorkBook.Sheets;
    Sheets_1 = Sheets.Item(1);
    
    RGB = Sheets_1.Range(['B2:D',num2str(i+1)]).value
%     cell2mat(RGB(1,:))
    for j = 2:i+1
        SetColor(Sheets_1,['E',num2str(j)],cell2mat(RGB(j-1,:)))
    end
    ReadExcel.SaveAs([pwd, ['\增加',num2str(i),'个点(带颜色).xlsx']]);
end

Excel.Quit;     % 关闭excel

function SetColor(sheet, strRange, dColor)
    %
    C_r = round(dColor(1));
    C_g = round(dColor(2));
    C_b = round(dColor(3));
    color = hex2dec([dec2hex(C_b,2) dec2hex(C_g,2) dec2hex(C_r,2)]);
    sheet.Range(strRange).Interior.Color = color;
end