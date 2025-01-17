;; Auto-generated. Do not edit!


(when (boundp 'third_task::Distance)
  (if (not (find-package "THIRD_TASK"))
    (make-package "THIRD_TASK"))
  (shadow 'Distance (find-package "THIRD_TASK")))
(unless (find-package "THIRD_TASK::DISTANCE")
  (make-package "THIRD_TASK::DISTANCE"))
(unless (find-package "THIRD_TASK::DISTANCEREQUEST")
  (make-package "THIRD_TASK::DISTANCEREQUEST"))
(unless (find-package "THIRD_TASK::DISTANCERESPONSE")
  (make-package "THIRD_TASK::DISTANCERESPONSE"))

(in-package "ROS")





(defclass third_task::DistanceRequest
  :super ros::object
  :slots (_x1 _y1 _x2 _y2 ))

(defmethod third_task::DistanceRequest
  (:init
   (&key
    ((:x1 __x1) 0.0)
    ((:y1 __y1) 0.0)
    ((:x2 __x2) 0.0)
    ((:y2 __y2) 0.0)
    )
   (send-super :init)
   (setq _x1 (float __x1))
   (setq _y1 (float __y1))
   (setq _x2 (float __x2))
   (setq _y2 (float __y2))
   self)
  (:x1
   (&optional __x1)
   (if __x1 (setq _x1 __x1)) _x1)
  (:y1
   (&optional __y1)
   (if __y1 (setq _y1 __y1)) _y1)
  (:x2
   (&optional __x2)
   (if __x2 (setq _x2 __x2)) _x2)
  (:y2
   (&optional __y2)
   (if __y2 (setq _y2 __y2)) _y2)
  (:serialization-length
   ()
   (+
    ;; float64 _x1
    8
    ;; float64 _y1
    8
    ;; float64 _x2
    8
    ;; float64 _y2
    8
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; float64 _x1
       (sys::poke _x1 (send s :buffer) (send s :count) :double) (incf (stream-count s) 8)
     ;; float64 _y1
       (sys::poke _y1 (send s :buffer) (send s :count) :double) (incf (stream-count s) 8)
     ;; float64 _x2
       (sys::poke _x2 (send s :buffer) (send s :count) :double) (incf (stream-count s) 8)
     ;; float64 _y2
       (sys::poke _y2 (send s :buffer) (send s :count) :double) (incf (stream-count s) 8)
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; float64 _x1
     (setq _x1 (sys::peek buf ptr- :double)) (incf ptr- 8)
   ;; float64 _y1
     (setq _y1 (sys::peek buf ptr- :double)) (incf ptr- 8)
   ;; float64 _x2
     (setq _x2 (sys::peek buf ptr- :double)) (incf ptr- 8)
   ;; float64 _y2
     (setq _y2 (sys::peek buf ptr- :double)) (incf ptr- 8)
   ;;
   self)
  )

(defclass third_task::DistanceResponse
  :super ros::object
  :slots (_distance ))

(defmethod third_task::DistanceResponse
  (:init
   (&key
    ((:distance __distance) 0.0)
    )
   (send-super :init)
   (setq _distance (float __distance))
   self)
  (:distance
   (&optional __distance)
   (if __distance (setq _distance __distance)) _distance)
  (:serialization-length
   ()
   (+
    ;; float64 _distance
    8
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; float64 _distance
       (sys::poke _distance (send s :buffer) (send s :count) :double) (incf (stream-count s) 8)
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; float64 _distance
     (setq _distance (sys::peek buf ptr- :double)) (incf ptr- 8)
   ;;
   self)
  )

(defclass third_task::Distance
  :super ros::object
  :slots ())

(setf (get third_task::Distance :md5sum-) "a7986c87b5a540f05187a6ffc4756d6c")
(setf (get third_task::Distance :datatype-) "third_task/Distance")
(setf (get third_task::Distance :request) third_task::DistanceRequest)
(setf (get third_task::Distance :response) third_task::DistanceResponse)

(defmethod third_task::DistanceRequest
  (:response () (instance third_task::DistanceResponse :init)))

(setf (get third_task::DistanceRequest :md5sum-) "a7986c87b5a540f05187a6ffc4756d6c")
(setf (get third_task::DistanceRequest :datatype-) "third_task/DistanceRequest")
(setf (get third_task::DistanceRequest :definition-)
      "# third_task/srv/Distance.srv
float64 x1
float64 y1
float64 x2
float64 y2
---
float64 distance

")

(setf (get third_task::DistanceResponse :md5sum-) "a7986c87b5a540f05187a6ffc4756d6c")
(setf (get third_task::DistanceResponse :datatype-) "third_task/DistanceResponse")
(setf (get third_task::DistanceResponse :definition-)
      "# third_task/srv/Distance.srv
float64 x1
float64 y1
float64 x2
float64 y2
---
float64 distance

")



(provide :third_task/Distance "a7986c87b5a540f05187a6ffc4756d6c")


