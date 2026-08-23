
 <p align="left">
  <img src="https://github.com/AncelmoSilva/ampulselog/blob/main/TAMPULSELOG.png"> 
 </p>
 
  ## Custom Visual Log Component for Lazarus / Free Pascal ##  

  Component: **AmpulseLog**   
  Version: 1.0.0  
  Base Class: TCustomListBox  
  Platform: Lazarus / Free Pascal / LCL  
   
  **Overview:**    
  AmpulseLog is a visual logging component for Lazarus applications, designed to display application    
  messages in an organized, colorful and easy-to-read format.    
  The component supports different log levels, timestamps, customizable font and background colors,    
  automatic scrolling, memory limits, file operations and clipboard support.    


  **Features:**    

  - ℹ️ INFO — informative messages
  - ✅ SUCCESS / OK — success messages
  - ⚠️ WARNING / WARNING — warning messages
  - ❌ ERROR / ERROR — error messages
  - 🖍️ Owner Draw — custom drawing of logs
  - 🕒 Date and time — timestamp of each message
  - 🎨 Colored font — configurable colors per level
  - 🖌️ Colored background — configurable background colors per level
  - 🔄 AutoScroll — automatic scrolling to the last record
  - 🔢 Count — number of records currently stored
  - 📦 MaxItems — limits the number of records kept in memory
  - 💾 SaveToFile — saves the complete log content to a file
  - ➕ AppendToFile — adds new records to the file
  - 📋 Clipboard — copies log content to the clipboard
  - 🧹 Clear — clears all logs
  - 🖱️ PopupMenu — supports LCL's TPopupMenu
  - ⚙️ Configurable Properties — colors and behavior can be changed via the Object Inspector

 
  **Log Levels:**  
    The component has four message levels:    
  |  Level     |  Prefix  |  Description                             |  
  | ---------- | -------- |----------------------------------------- |  
  | ℹ️ Info    | [INFO]   | General information                      |  
  | ✅ Success | [OK]     | Operation successfully completed         |  
  | ⚠️ Warning | [WARNING]| Warning or situation requiring attention |  
  | ❌ Error   | [ERROR]  | Error or failure in operation            |  

 
  
  **Package Structure**    
  The component distribution contains:  
  ├── ampulselog.lpk  
  ├── ampulselog.pas  
  ├── uampulselog.pas  
  ├── uampulselogreg.pas  
  ├── uampulselogreg.rc  
  ├── TAMPULSELOG.png  
  ├── HELP.pdf  
  ├── LICENSE  
  └── README.md  

**For more information, please refer to the HELP.pdf file included in the package.**  

  **License:**  
  AmpulseLog is distributed under the license:  
  Modified LGPL (FPC)  
  See the LICENSE file for the full license text.  
  
  This component is free software; you can redistribute it and/or modify  
  it under the terms of the GNU Lesser General Public License (LGPL) as  
  modified by the Free Pascal Team (FPC modified LGPL v2 or later).  

  As a special exception, the copyright holder permits the static linking  
  of this component into commercial or closed-source executables without  
  the obligation to open the main application source code.  
  
  
  *Contacts:*      
  Email: suporte@raquel.adm.br   
  https://github.com/AncelmoSilva/ampulselog/    
  Copyright (C) 2026 R. Ancelmo S Silva    
 
 
 

 ⭐ If this component was helpful for your project,      
   please consider leaving a star on the repository and sending your feedback!     


---

