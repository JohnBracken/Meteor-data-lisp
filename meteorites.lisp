
#|
This script is an example of how to use lisp to read and analyze CSV data files.
It shows examples of how to loop through data rows and perform 
calcutions on specific columns.
cons function used to create lists, cdr and car are used to take lists apart.  Lists are spaced objects in parentheses.
car gets first item in list, cdr gets the rest of the items in the list.
|#

(load "~/.quicklisp/setup.lisp") ;Load quicklisp package manager
(ql:quickload "cl-csv") ;load cl-csv package to manipulate csv files.
(ql:quickload "parse-float")
(defvar meteorite-table (cl-csv:read-csv #P"Meteorite_Landings.csv")) ;call read-csv function (a symbol) from cl-csv package to load meteorite landings CSV into a list of lists
(defvar headers (car meteorite-table)) ;get the first item in the CSV list, which is itself a list containing the column headers from the CSV file.
(defvar meteor-data (cdr meteorite-table)) ; get the rest of the items in the CSV list, which are lists containing all the meteorite data. 
(format t "~a ~%"  headers)  ;print the headers to terminal.  ~a will print the headers symbol/variable and ~% will print a newline.
(format t "~a ~%"  (cadr meteor-data))  ;print the first item of the rest of meteor data, which is actually the 2nd row of data.
(format t "column of meteorite mass column: ~d ~%" (position "mass_(g)" headers :test #'string=))

(defvar *sum* 0) ;variable for sum of meteorite masses
;; add meteorite masses together using if-progn statements


;; Loop through meteorite data.  Calculate the sum of meteorite masses (4th column)
(loop for a in meteor-data ;loop for meteorite data
    do (   
          if (string/= "" (nth 4 a)) ;if meteorite mass column is not empty
             (progn ;do all this stuff
                (setq *sum* (+ *sum* (parse-float:parse-float (nth 4 a)))) ;add to meteorite masses
                (print *sum*) ;print meteorite masses
             )
        )
)



(setq *sum* 0) ;variable for sum of meteorite masses
;; Calculate the total meteorite mass using the when construct
(loop for a in meteor-data      
    do (
           when (string/="" (nth 4 a)) 
               (setq *sum* (+ *sum* (parse-float:parse-float (nth 4 a))))
           (print *sum*)
       )
)


(setq *sum* 0) ;variable for sum of meteorite masses
;;Calculate the total meteorite mass using the unless construct
(loop for a in meteor-data      
    do (
           unless (string="" (nth 4 a)) 
               (setq *sum* (+ *sum* (parse-float:parse-float (nth 4 a))))
           (print *sum*)
       )
)

(setq *sum* 0)
;;Loop construct using when construct to do multiple things.
(loop for a in meteor-data
     when (string/= "" (nth 4 a))
         do (setq *sum* (+ *sum* (parse-float:parse-float (nth 4 a))))
         and do (print *sum*)
         and do (print "Still adding up...")
         and do (print "Thanks for waiting..")
)

;;Same thing with the unless construct
(setq *sum* 0)
(loop for a in meteor-data
     unless (string= "" (nth 4 a))
         do (setq *sum* (+ *sum* (parse-float:parse-float (nth 4 a))))
         and do (print *sum*)
         and do (print "Still adding up...")
         and do (print "Thanks for waiting..")
)

;;Dolist to include a multi-condition statement that acts on the list.
(setq *sum* 0)
(defvar *test* 0)
(dolist (m meteor-data)
  (cond ( (string= "" (nth 4 m)) (print "no result"))
        ( (string/= "" (nth 4 m)) (setq *sum* (+ *sum* (parse-float:parse-float (nth 4 m))) ) (print *sum*) ))
(setq *test* (+ *test* 1))
(print *test*)
(print m)
)


;;Instead of using dolist, use a loop to run several statements and
;;a multi-conditional statement.
(setq *sum* 0)
(defvar *test* 0)
(defvar *meteor_row*)
(loop
  (setq *meteor_row* (nth *test* meteor-data))
  (cond ( (string= "" (nth 4 *meteor_row*)) (print "no result"))
        ( (string/= "" (nth 4 *meteor_row*)) 
             (setq *sum* (+ *sum* (parse-float:parse-float (nth 4 *meteor_row*))) ) 
             (print *sum*) ))
(setq *test* (+ *test* 1))
(print *test*)
(print *meteor_row*)
(when (equal *test* (length meteor-data)) (return *test*))
)


