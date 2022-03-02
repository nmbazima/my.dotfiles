(in-package #:nyxt-user)

;;import Files
;;(dolist (files (list (nyxt-init-file "statusline.lisp")
;;                    (nyxt-init-file "stylesheet.lisp")))
;; (load file))

;;loading of config files
;;add theme here
(nyxt::load-lisp "~/.config/nyxt/themes/drgn-dark.lisp")
;;(nyxt::load-lisp "~/.config/nyxt/statusline.lisp")
;;(nyxt::load-lisp "~/.config/nyxt/stylesheet.lisp")
;;base
;;(nyxt::load-lisp "~/.config/nyxt/base/keybindings.lisp")
;;(nyxt::load-lisp "~/.config/nyxt/base/urlprompt.lisp")
;;(nyxt::load-lisp "~/.config/nyxt/base/commands.lisp")
(nyxt::load-lisp "~/.config/nyxt/base/glyphs.lisp")
;;extending
;;(nyxt::load-lisp "~/.config/nyxt/ex/specificurl.lisp")

(define-configuration prompt-buffer
  ((style (str:concat
           %slot-default%
           (cl-css:css
            '((body
               :background-color "black"
               :color "#808080")
              ("#prompt-area"
               :background-color "black")
              ;; The area you input text in.
              ("#input"
               :background-color "white")
              (".source-name"
               :color "black"
               :background-color "gray")
              (".source-content"
               :background-color "black")
              (".source-content th"
               :border "1px solid lightgray"
               :background-color "black")
              ;; The currently highlighted option.
              ("#selection"
               :background-color "#37a8e4"
               :color "black")
              (.marked :background-color "darkgray"
                       :font-weight "bold"
                       :color "white")
              (.selected :background-color "black"
                         :color "white")))))))

;;; Panel buffers are the same in regards to style.
(define-configuration (internal-buffer panel-buffer)
  ((style
    (str:concat
     %slot-default%
     (cl-css:css
      '((body
         :background-color "black"
         :color "lightgray")
        (hr
         :color "darkgray")
        (a
         :color "lightgray")
        (.button
         :color "lightgray"
         :background-color "gray")))))))

(define-configuration window
  ((message-buffer-style
    (str:concat
     %slot-default%
     (cl-css:css
      '((body
         :background-color "black"
         :color "white")))))))


;;configuration for browser, this is for Nyxt to never prompt me about restoring the previous session.
(define-configuration browser
 ((session-restore-prompt :never-restore)))


;;configuration for buffer and nosave buffer to have reduce tracking by default
(define-configuration (web-buffer nosave-buffer)
  ((default-modes `(reduce-tracking-mode
                    auto-mode
                    ,@%slot-default%))))


;;; Dark-mode is a simple mode for simple HTML pages to color those in
;;; a darker palette. I don't like the default gray-ish colors,
;;; though. Thus, I'm overriding those to be a bit more laconia-like.
(define-configuration nyxt/style-mode:dark-mode
  ((style #.(cl-css:css
             '((*
                :background-color "black !important"
                :background-image "none !important"
                :color "white")
               (a
                :background-color "black !important"
                :background-image "none !important"
                :color "#556B2F !important"))))))

;;setting new buffer url and having nyxt start full screen
(defmethod nyxt::startup ((browser browser) urls)
  "Home"
  (window-make browser)
  (let ((window (current-window)))
    (window-set-buffer window (make-buffer :url (quri:uri "https://www.duckduckgo.com/")))
    (toggle-fullscreen window)))

;;when reloading init.lisp file shows in message bar once finished
(echo "Loaded config.")
