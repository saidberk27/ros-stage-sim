;; Auto-generated. Do not edit!


(when (boundp 'third_task::Coordinates)
  (if (not (find-package "THIRD_TASK"))
    (make-package "THIRD_TASK"))
  (shadow 'Coordinates (find-package "THIRD_TASK")))
(unless (find-package "THIRD_TASK::COORDINATES")
  (make-package "THIRD_TASK::COORDINATES"))

(in-package "ROS")
;;//! \htmlinclude Coordinates.msg.html


(defclass third_task::Coordinates
  :super ros::object
  :slots (_x _y ))

(defmethod third_task::Coordinates
  (:init
   (&key
    ((:x __x) 0.0)
    ((:y __y) 0.0)
    )
   (send-super :init)
   (setq _x (float __x))
   (setq _y (float __y))
   self)
  (:x
   (&optional __x)
   (if __x (setq _x __x)) _x)
  (:y
   (&optional __y)
   (if __y (setq _y __y)) _y)
  (:serialization-length
   ()
   (+
    ;; float64 _x
    8
    ;; float64 _y
    8
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; float64 _x
       (sys::poke _x (send s :buffer) (send s :count) :double) (incf (stream-count s) 8)
     ;; float64 _y
       (sys::poke _y (send s :buffer) (send s :count) :double) (incf (stream-count s) 8)
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; float64 _x
     (setq _x (sys::peek buf ptr- :double)) (incf ptr- 8)
   ;; float64 _y
     (setq _y (sys::peek buf ptr- :double)) (incf ptr- 8)
   ;;
   self)
  )

(setf (get third_task::Coordinates :md5sum-) "209f516d3eb691f0663e25cb750d67c1")
(setf (get third_task::Coordinates :datatype-) "third_task/Coordinates")
(setf (get third_task::Coordinates :definition-)
      "# third_task/msg/Coordinates.msg
float64 x
float64 y

")



(provide :third_task/Coordinates "209f516d3eb691f0663e25cb750d67c1")


