GGR_CMS
===
With GGR_CMS， you can easily change your website content by Google Spreadsheet.<br>


User Story
---
Completed:
  1. 使用者可以輸入 Google spreadsheet的網址作為數據和內容的來源<br>
  2. 使用者可以使用 Google spreadsheet 中的特定欄或列，來定義XML tag的內容元素，該應用程式會生成一組 JS 文件<br>
  3. 使用者可以選擇spreadsheet的某一個tab是要以欄或是列的方式讀取資料<br>
  4. 使用者可以選擇特定欄或列的資料性質為文字、圖片或是影片<br>
  5. 使用者可以自行為XML tag取名<br>
  6. 透過點選複製按鈕可以複製該 JS 文件內文<br>
  7. 使用者可以將spreadsheet欄位與對應的XML tag名稱 輸出成PDF以便查詢<br>
  
In progress:
  1. 希望把網站改成AJAX<br>
  2. 重構程式碼<br>
  3. 改變資料存法以增進效能<br>
  4. 部署上已購買的網域<br>
  5. 調整CSS樣式<br>
  6. 改善使用者體驗<br>
  7. 目前 JS 文件內指定特定 XML tag的方法是透過id，希望可以改成別的屬性名稱<br>





Quick Start
---
Go to our https://ggr-cms.herokuapp.com/  <br>
Enter your Google Spreadsheet URL.<br>
Select col or row which the specified data will be read as for the tab.<br>
Select the type of your data(string, photos or video).<br>
Give XML tag a name.<br>
You can save the names of XML tags as a PDF file.<br>
Copy the Javascript file.<br>
Paste it in the html file of your website.<br>
Add the xml tag with the id selecting the specific value in the column you choose to the html file.<br>
Then, once you change your spreadsheet, your website also updates immediately.<br>

