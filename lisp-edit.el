;;; lisp-edit.el --- Structural editing helpers      -*- lexical-binding: t; -*-

;; Copyright (C) 2024  Arthur Miller

;; Author: Arthur Miller <arthur.miller@live.com>
;; Keywords: 

;; This program is free software; you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation, either version 3 of the License, or
;; (at your option) any later version.

;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.

;; You should have received a copy of the GNU General Public License
;; along with this program.  If not, see <https://www.gnu.org/licenses/>.

;;; Commentary:

;;; Code:
(defun line-empty-p ()
  (save-excursion
    (goto-char (pos-bol))
    (looking-at-p "^[[:space:]]*$")))

(defun kill-space-after (&optional back)
  "Clean whitespace chars after the `point'."
  (interactive)
  (save-excursion
    (let ((beg (point)))
      (skip-chars-forward "\s\n\t\v\r")
      (kill-region beg (point)))))

(defun kill-space-before ()
  "Clean whitespace chars before the `point'."
  (interactive)
  (save-excursion
    (let ((beg (point)))
      (skip-chars-backward "\s\n\t\v\r")
      (kill-region beg (point)))))

(defun evaporate-space ()
  "Clean whitespace chars around point."
  (interactive)
  (kill-space-after)
  (kill-space-before))

(defun evaporate-forward ()
  "Kill list after the point and clean whitespace."
  (interactive)
  (kill-sexp 1)
  (evaporate-space))

(defun evaporate-backward ()
  "Kill list before the point and clean whitespace."
  (interactive)
  (kill-sexp -1)
  (evaporate-space))

(defun kill-pair-after ()
  "Kill a pair of expressions after the point and clean whitespace."
  (interactive)
  (kill-sexp 2)
  (kill-space-after))

(defun kill-pair-before ()
  "Kill a pair of expressions before the point and clean whitespace."
  (interactive)
  (kill-sexp -2)
  (kill-space-before))

(defun evaporate-list ()
  "Kill current list and clean whitespace left."
  (interactive)
  (backward-up-list)
  (evaporate-forward)
  (evaporate-space))

(provide 'lisp-edit)
;;; lisp-edit.el ends here
