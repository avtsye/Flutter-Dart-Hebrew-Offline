# Flutter + Dart בעברית — ערכת Offline ל-Windows

מיזם קהילתי לאריזת סביבת פיתוח Flutter ו-Dart לשימוש במחשבים עם חיבור מוגבל לאינטרנט.

## מסלולים
- **Core** — Flutter (כולל Dart), פרויקט הדגמה ומדריכים בעברית. הוספת VS Code והרחבות אופליין מתוכננת לשלב הבא.
- **Windows** — Core + Flutter Windows engine artifacts. Native Visual Studio C++ build tools are still required separately.
- **Android** — Core + רכיבי Android SDK בסיסיים ומטמון Flutter ראשוני; מטמון Gradle מלא טרם נכלל.
- **Both** — מסלול Android יחד עם הכנה לפיתוח Windows. **חשוב:** בניית יישומי Windows דורשת בנוסף רכיבי Visual Studio C++ מתאימים במחשב. רכיבים אלו אינם כלולים במתקין הראשוני, ולכן בניית Windows אינה מובטחת במחשב מנותק עד להכנת Layout מורשה שלהם.

## הוראות שימוש
1. בדף **Actions** הפעילו **Build offline Windows kit** ובחרו core / android / windows / both.
2. לאחר שהריצה מסתיימת הורידו Artifact מסוג ZIP. ניתן להעביר אותו בדיסק-און-קי.
3. חלצו את ה-ZIP והפעילו את `install.cmd` מתוך התיקייה. המתקין מעתיק את הערכה לנתיב שהמשתמש בוחר ומגדיר את PATH עבור המשתמש.
4. פתחו חלון PowerShell חדש והריצו `flutter doctor -v`.
5. למדריכים פתחו `docs/index.html` מקומית.

## מגבלות שקיפות
- זוהי **תשתית ניסיונית ראשונית**, לא מתקין EXE חתום. בדיקות הבנייה וניתוק מהרשת חייבות לעבור לפני שמגדירים אותו מתאים להפצה.
- Android SDK וחבילות Gradle נוספות תלויות בפרויקט, בגרסאות ובפלאגינים; לא כל אפליקציה חדשה תיבנה ללא אינטרנט.
- בהתקנת Android במחשב חדש יתכן צורך באישור רישיונות SDK.
- כדי לבנות Windows יש להכין בנפרד Visual Studio 2022 עם Desktop development with C++ ורכיבי MSVC/Windows SDK. אין להעביר קבצים קנייניים בלי לוודא הרשאה ותנאי שימוש.
- VS Code והרחבות VSIX טרם נארזו בגרסת התשתית; יש להוסיפם בהמשך.
- יש לעיין ברישיונות Flutter, Dart, VS Code, Android SDK וכלי צד שלישי לפני הפצה פומבית.

מדריך: [docs/index.html](docs/index.html)
