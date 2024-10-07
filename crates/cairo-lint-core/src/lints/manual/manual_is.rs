use cairo_lang_defs::plugin::PluginDiagnostic;
use cairo_lang_diagnostics::Severity;
use cairo_lang_syntax::node::ast::{ExprIf, ExprMatch};
use cairo_lang_syntax::node::db::SyntaxGroup;
use cairo_lang_syntax::node::TypedSyntaxNode;

use crate::lints::manual::{check_manual, check_manual_if, ManualLint};

pub const MANUAL_IS_SOME: &str = "Manual match for `is_some` detected. Consider using `is_some()` instead";
pub(crate) mod some {
    pub(crate) const LINT_NAME: &str = "manual_is_some";
}
pub(crate) mod none {
    pub(crate) const LINT_NAME: &str = "manual_is_none";
}
pub(crate) mod ok {
    pub(crate) const LINT_NAME: &str = "manual_is_ok";
}
pub(crate) mod err {
    pub(crate) const LINT_NAME: &str = "manual_is_err";
}

pub const MANUAL_IS_NONE: &str = "Manual match for `is_none` detected. Consider using `is_none()` instead";
pub const MANUAL_IS_OK: &str = "Manual match for `is_ok` detected. Consider using `is_ok()` instead";
pub const MANUAL_IS_ERR: &str = "Manual match for `is_err` detected. Consider using `is_err()` instead";

pub fn check_manual_is(db: &dyn SyntaxGroup, expr_match: &ExprMatch, diagnostics: &mut Vec<PluginDiagnostic>) {
    if check_manual(db, expr_match, ManualLint::ManualIsSome, some::LINT_NAME) {
        diagnostics.push(PluginDiagnostic {
            stable_ptr: expr_match.as_syntax_node().stable_ptr(),
            message: MANUAL_IS_SOME.to_owned(),
            severity: Severity::Warning,
        });
    }
    if check_manual(db, expr_match, ManualLint::ManualIsNone, none::LINT_NAME) {
        diagnostics.push(PluginDiagnostic {
            stable_ptr: expr_match.as_syntax_node().stable_ptr(),
            message: MANUAL_IS_NONE.to_owned(),
            severity: Severity::Warning,
        });
    }
    if check_manual(db, expr_match, ManualLint::ManualIsOk, ok::LINT_NAME) {
        diagnostics.push(PluginDiagnostic {
            stable_ptr: expr_match.as_syntax_node().stable_ptr(),
            message: MANUAL_IS_OK.to_owned(),
            severity: Severity::Warning,
        });
    }
    if check_manual(db, expr_match, ManualLint::ManualIsErr, err::LINT_NAME) {
        diagnostics.push(PluginDiagnostic {
            stable_ptr: expr_match.as_syntax_node().stable_ptr(),
            message: MANUAL_IS_ERR.to_owned(),
            severity: Severity::Warning,
        });
    }
}

pub fn check_manual_if_is(db: &dyn SyntaxGroup, expr_if: &ExprIf, diagnostics: &mut Vec<PluginDiagnostic>) {
    if check_manual_if(db, expr_if, ManualLint::ManualIsSome, some::LINT_NAME) {
        diagnostics.push(PluginDiagnostic {
            stable_ptr: expr_if.as_syntax_node().stable_ptr(),
            message: MANUAL_IS_SOME.to_owned(),
            severity: Severity::Warning,
        });
    }
    if check_manual_if(db, expr_if, ManualLint::ManualIsNone, none::LINT_NAME) {
        diagnostics.push(PluginDiagnostic {
            stable_ptr: expr_if.as_syntax_node().stable_ptr(),
            message: MANUAL_IS_NONE.to_owned(),
            severity: Severity::Warning,
        });
    }
    if check_manual_if(db, expr_if, ManualLint::ManualIsOk, ok::LINT_NAME) {
        diagnostics.push(PluginDiagnostic {
            stable_ptr: expr_if.as_syntax_node().stable_ptr(),
            message: MANUAL_IS_OK.to_owned(),
            severity: Severity::Warning,
        });
    }
    if check_manual_if(db, expr_if, ManualLint::ManualIsErr, err::LINT_NAME) {
        diagnostics.push(PluginDiagnostic {
            stable_ptr: expr_if.as_syntax_node().stable_ptr(),
            message: MANUAL_IS_ERR.to_owned(),
            severity: Severity::Warning,
        });
    }
}
