/* @ds-bundle: {"format":3,"namespace":"HatCoatBootsDesignSystem_0d0e5a","components":[{"name":"Badge","sourcePath":"components/core/Badge.jsx"},{"name":"Button","sourcePath":"components/core/Button.jsx"},{"name":"Card","sourcePath":"components/core/Card.jsx"},{"name":"Chip","sourcePath":"components/core/Chip.jsx"},{"name":"IconButton","sourcePath":"components/core/IconButton.jsx"},{"name":"MarginNote","sourcePath":"components/core/MarginNote.jsx"},{"name":"ProgressDots","sourcePath":"components/core/ProgressDots.jsx"},{"name":"Switch","sourcePath":"components/core/Switch.jsx"},{"name":"Callout","sourcePath":"components/reader/Callout.jsx"},{"name":"LayerToggle","sourcePath":"components/reader/LayerToggle.jsx"},{"name":"OverlayStage","sourcePath":"components/reader/OverlayStage.jsx"}],"sourceHashes":{"components/core/Badge.jsx":"052ff0e910df","components/core/Button.jsx":"bbf6bedb0f3f","components/core/Card.jsx":"37ca49a15d22","components/core/Chip.jsx":"33be10815494","components/core/IconButton.jsx":"558102464a3d","components/core/MarginNote.jsx":"b5c742bab6fb","components/core/ProgressDots.jsx":"735e25a3d4ad","components/core/Switch.jsx":"97475f3f24e6","components/reader/Callout.jsx":"2a2012f574ba","components/reader/LayerToggle.jsx":"b7425862bc26","components/reader/OverlayStage.jsx":"4583800df690","ui_kits/series-site/Hero.jsx":"5083d3b3459e","ui_kits/series-site/HowItWorks.jsx":"a1fc3f5777d9","ui_kits/series-site/SeriesShelf.jsx":"9b808408badd","ui_kits/series-site/SiteApp.jsx":"93b250a12c72","ui_kits/series-site/SiteFooter.jsx":"eab9b671f928","ui_kits/series-site/SiteHeader.jsx":"b78ed04e6466","ui_kits/storybook-reader/BeatPanel.jsx":"2e021cb8fd10","ui_kits/storybook-reader/ReaderApp.jsx":"572b4df61ef7","ui_kits/storybook-reader/ReaderData.jsx":"4cbb76a1c015","ui_kits/storybook-reader/SceneStage.jsx":"d0d8b41e178e"},"inlinedExternals":[],"unexposedExports":[]} */

(() => {

const __ds_ns = (window.HatCoatBootsDesignSystem_0d0e5a = window.HatCoatBootsDesignSystem_0d0e5a || {});

const __ds_scope = {};

(__ds_ns.__errors = __ds_ns.__errors || []);

// components/core/Badge.jsx
try { (() => {
function _extends() { return _extends = Object.assign ? Object.assign.bind() : function (n) { for (var e = 1; e < arguments.length; e++) { var t = arguments[e]; for (var r in t) ({}).hasOwnProperty.call(t, r) && (n[r] = t[r]); } return n; }, _extends.apply(null, arguments); }
/**
 * Badge — a tiny status/count marker. Solid sticker dot or a small pill.
 */
function Badge({
  children,
  tone = 'coat',
  style = {},
  ...rest
}) {
  const tones = {
    hat: {
      bg: 'var(--hat-500)',
      fg: 'var(--ink-900)'
    },
    coat: {
      bg: 'var(--coat-500)',
      fg: 'var(--cloud)'
    },
    boots: {
      bg: 'var(--boots-500)',
      fg: 'var(--cloud)'
    },
    leaf: {
      bg: 'var(--leaf-500)',
      fg: 'var(--cloud)'
    },
    berry: {
      bg: 'var(--berry)',
      fg: 'var(--cloud)'
    }
  };
  const t = tones[tone] || tones.coat;
  return /*#__PURE__*/React.createElement("span", _extends({
    style: {
      display: 'inline-flex',
      alignItems: 'center',
      justifyContent: 'center',
      minWidth: 22,
      height: 22,
      padding: '0 7px',
      fontFamily: 'var(--font-display)',
      fontWeight: 'var(--w-semibold)',
      fontSize: 'var(--text-2xs)',
      color: t.fg,
      background: t.bg,
      border: 'var(--border-hair) solid var(--ink-900)',
      borderRadius: 'var(--radius-pill)',
      lineHeight: 1,
      ...style
    }
  }, rest), children);
}
Object.assign(__ds_scope, { Badge });
})(); } catch (e) { __ds_ns.__errors.push({ path: "components/core/Badge.jsx", error: String((e && e.message) || e) }); }

// components/core/Button.jsx
try { (() => {
function _extends() { return _extends = Object.assign ? Object.assign.bind() : function (n) { for (var e = 1; e < arguments.length; e++) { var t = arguments[e]; for (var r in t) ({}).hasOwnProperty.call(t, r) && (n[r] = t[r]); } return n; }, _extends.apply(null, arguments); }
/**
 * Button — the chunky "sticker" action used all over Hat, Coat & Boots.
 * Ink outline + hard offset shadow that presses down when clicked.
 */
function Button({
  children,
  variant = 'coat',
  size = 'md',
  iconLeft = null,
  iconRight = null,
  fullWidth = false,
  disabled = false,
  type = 'button',
  href,
  onClick,
  style = {},
  ...rest
}) {
  const palettes = {
    hat: {
      bg: 'var(--hat-500)',
      fg: 'var(--ink-900)',
      edge: 'var(--hat-900)'
    },
    coat: {
      bg: 'var(--coat-500)',
      fg: 'var(--cloud)',
      edge: 'var(--coat-900)'
    },
    boots: {
      bg: 'var(--boots-500)',
      fg: 'var(--cloud)',
      edge: 'var(--boots-900)'
    },
    leaf: {
      bg: 'var(--leaf-500)',
      fg: 'var(--cloud)',
      edge: 'var(--leaf-700)'
    },
    sun: {
      bg: 'var(--sun)',
      fg: 'var(--ink-900)',
      edge: 'var(--hat-700)'
    },
    cream: {
      bg: 'var(--cloud)',
      fg: 'var(--ink-900)',
      edge: 'var(--ink-900)'
    },
    ghost: {
      bg: 'transparent',
      fg: 'var(--ink-900)',
      edge: 'var(--ink-900)'
    }
  };
  const sizes = {
    sm: {
      pad: '7px 16px',
      font: 'var(--text-sm)',
      gap: '6px'
    },
    md: {
      pad: '11px 22px',
      font: 'var(--text-md)',
      gap: '8px'
    },
    lg: {
      pad: '15px 30px',
      font: 'var(--text-lg)',
      gap: '10px'
    }
  };
  const p = palettes[variant] || palettes.coat;
  const s = sizes[size] || sizes.md;
  const base = {
    display: fullWidth ? 'flex' : 'inline-flex',
    width: fullWidth ? '100%' : 'auto',
    alignItems: 'center',
    justifyContent: 'center',
    gap: s.gap,
    padding: s.pad,
    fontFamily: 'var(--font-display)',
    fontWeight: 'var(--w-semibold)',
    fontSize: s.font,
    lineHeight: 1,
    color: p.fg,
    background: p.bg,
    border: 'var(--border-ink) solid var(--ink-900)',
    borderRadius: 'var(--radius-pill)',
    boxShadow: `3px 3px 0 ${p.edge}`,
    cursor: disabled ? 'not-allowed' : 'pointer',
    opacity: disabled ? 0.5 : 1,
    transition: 'var(--t-press)',
    transform: 'translate(0,0)',
    textDecoration: 'none',
    whiteSpace: 'nowrap',
    userSelect: 'none',
    WebkitTapHighlightColor: 'transparent',
    ...style
  };
  const press = (e, on) => {
    if (disabled) return;
    e.currentTarget.style.transform = on ? 'translate(2px,2px)' : 'translate(0,0)';
    e.currentTarget.style.boxShadow = on ? `1px 1px 0 ${p.edge}` : `3px 3px 0 ${p.edge}`;
  };
  const content = /*#__PURE__*/React.createElement(React.Fragment, null, iconLeft && /*#__PURE__*/React.createElement("span", {
    style: {
      display: 'inline-flex',
      fontSize: '1.1em'
    }
  }, iconLeft), children, iconRight && /*#__PURE__*/React.createElement("span", {
    style: {
      display: 'inline-flex',
      fontSize: '1.1em'
    }
  }, iconRight));
  const handlers = {
    onMouseDown: e => press(e, true),
    onMouseUp: e => press(e, false),
    onMouseLeave: e => press(e, false),
    onClick: disabled ? undefined : onClick
  };
  if (href && !disabled) {
    return /*#__PURE__*/React.createElement("a", _extends({
      href: href,
      style: base
    }, handlers, rest), content);
  }
  return /*#__PURE__*/React.createElement("button", _extends({
    type: type,
    disabled: disabled,
    style: base
  }, handlers, rest), content);
}
Object.assign(__ds_scope, { Button });
})(); } catch (e) { __ds_ns.__errors.push({ path: "components/core/Button.jsx", error: String((e && e.message) || e) }); }

// components/core/Card.jsx
try { (() => {
function _extends() { return _extends = Object.assign ? Object.assign.bind() : function (n) { for (var e = 1; e < arguments.length; e++) { var t = arguments[e]; for (var r in t) ({}).hasOwnProperty.call(t, r) && (n[r] = t[r]); } return n; }, _extends.apply(null, arguments); }
/**
 * Card — a storybook panel. Ink outline + soft paper-lift shadow, with an
 * optional strip of "tape" across a top corner like a scrapbook page.
 */
function Card({
  children,
  title,
  eyebrow,
  tone = 'cream',
  tape = false,
  pad = 'md',
  style = {},
  ...rest
}) {
  const tones = {
    cream: 'var(--cloud)',
    paper: 'var(--paper-100)',
    hat: 'var(--hat-100)',
    coat: 'var(--coat-100)',
    boots: 'var(--boots-100)',
    leaf: 'var(--leaf-100)',
    sky: 'var(--sky-100)'
  };
  const pads = {
    sm: 'var(--space-4)',
    md: 'var(--space-5)',
    lg: 'var(--space-6)'
  };
  return /*#__PURE__*/React.createElement("div", _extends({
    style: {
      position: 'relative',
      background: tones[tone] || tones.cream,
      border: 'var(--border-ink) solid var(--ink-900)',
      borderRadius: 'var(--radius-lg)',
      boxShadow: 'var(--shadow-card)',
      padding: pads[pad] || pads.md,
      color: 'var(--text-body)',
      ...style
    }
  }, rest), tape && /*#__PURE__*/React.createElement("span", {
    "aria-hidden": "true",
    style: {
      position: 'absolute',
      top: -12,
      left: 22,
      width: 72,
      height: 24,
      background: 'var(--tape)',
      border: '1.5px solid rgba(46,36,24,0.25)',
      transform: 'rotate(-5deg)',
      boxShadow: '0 2px 6px rgba(46,36,24,0.18)'
    }
  }), eyebrow && /*#__PURE__*/React.createElement("div", {
    style: {
      fontFamily: 'var(--font-hand)',
      fontSize: 'var(--text-md)',
      color: 'var(--coat-700)',
      marginBottom: '2px',
      transform: 'rotate(-1deg)'
    }
  }, eyebrow), title && /*#__PURE__*/React.createElement("h3", {
    style: {
      margin: '0 0 var(--space-3)',
      fontFamily: 'var(--font-display)',
      fontWeight: 'var(--w-semibold)',
      fontSize: 'var(--text-xl)',
      lineHeight: 'var(--leading-snug)',
      color: 'var(--ink-900)'
    }
  }, title), children);
}
Object.assign(__ds_scope, { Card });
})(); } catch (e) { __ds_ns.__errors.push({ path: "components/core/Card.jsx", error: String((e && e.message) || e) }); }

// components/core/Chip.jsx
try { (() => {
function _extends() { return _extends = Object.assign ? Object.assign.bind() : function (n) { for (var e = 1; e < arguments.length; e++) { var t = arguments[e]; for (var r in t) ({}).hasOwnProperty.call(t, r) && (n[r] = t[r]); } return n; }, _extends.apply(null, arguments); }
/**
 * Chip — a rounded category tag. The three brand chips (hat/coat/boots)
 * carry a colored dot so kids can sort parts of the house at a glance.
 */
function Chip({
  children,
  tone = 'neutral',
  dot = true,
  size = 'md',
  onClick,
  style = {},
  ...rest
}) {
  const tones = {
    hat: {
      bg: 'var(--hat-100)',
      fg: 'var(--hat-900)',
      dot: 'var(--hat-500)'
    },
    coat: {
      bg: 'var(--coat-100)',
      fg: 'var(--coat-900)',
      dot: 'var(--coat-500)'
    },
    boots: {
      bg: 'var(--boots-100)',
      fg: 'var(--boots-900)',
      dot: 'var(--boots-500)'
    },
    leaf: {
      bg: 'var(--leaf-100)',
      fg: 'var(--leaf-700)',
      dot: 'var(--leaf-500)'
    },
    sky: {
      bg: 'var(--sky-100)',
      fg: 'var(--sky-700)',
      dot: 'var(--sky-500)'
    },
    neutral: {
      bg: 'var(--paper-100)',
      fg: 'var(--ink-700)',
      dot: 'var(--ink-500)'
    }
  };
  const sizes = {
    sm: {
      pad: '3px 10px',
      font: 'var(--text-2xs)',
      d: 7
    },
    md: {
      pad: '5px 13px',
      font: 'var(--text-xs)',
      d: 9
    }
  };
  const t = tones[tone] || tones.neutral;
  const s = sizes[size] || sizes.md;
  return /*#__PURE__*/React.createElement("span", _extends({
    onClick: onClick,
    style: {
      display: 'inline-flex',
      alignItems: 'center',
      gap: '7px',
      padding: s.pad,
      fontFamily: 'var(--font-body)',
      fontWeight: 'var(--w-bold)',
      fontSize: s.font,
      letterSpacing: '0.02em',
      color: t.fg,
      background: t.bg,
      border: 'var(--border-hair) solid var(--ink-900)',
      borderRadius: 'var(--radius-pill)',
      cursor: onClick ? 'pointer' : 'default',
      whiteSpace: 'nowrap',
      ...style
    }
  }, rest), dot && /*#__PURE__*/React.createElement("span", {
    style: {
      width: s.d,
      height: s.d,
      borderRadius: '50%',
      background: t.dot,
      border: '1.5px solid var(--ink-900)',
      flex: '0 0 auto'
    }
  }), children);
}
Object.assign(__ds_scope, { Chip });
})(); } catch (e) { __ds_ns.__errors.push({ path: "components/core/Chip.jsx", error: String((e && e.message) || e) }); }

// components/core/IconButton.jsx
try { (() => {
function _extends() { return _extends = Object.assign ? Object.assign.bind() : function (n) { for (var e = 1; e < arguments.length; e++) { var t = arguments[e]; for (var r in t) ({}).hasOwnProperty.call(t, r) && (n[r] = t[r]); } return n; }, _extends.apply(null, arguments); }
/**
 * IconButton — a round sticker button for a single glyph. Same press feel
 * as Button. Use for pager arrows, close, mute, etc.
 */
function IconButton({
  children,
  variant = 'cream',
  size = 'md',
  label,
  disabled = false,
  onClick,
  style = {},
  ...rest
}) {
  const palettes = {
    hat: {
      bg: 'var(--hat-500)',
      fg: 'var(--ink-900)',
      edge: 'var(--hat-900)'
    },
    coat: {
      bg: 'var(--coat-500)',
      fg: 'var(--cloud)',
      edge: 'var(--coat-900)'
    },
    boots: {
      bg: 'var(--boots-500)',
      fg: 'var(--cloud)',
      edge: 'var(--boots-900)'
    },
    leaf: {
      bg: 'var(--leaf-500)',
      fg: 'var(--cloud)',
      edge: 'var(--leaf-700)'
    },
    cream: {
      bg: 'var(--cloud)',
      fg: 'var(--ink-900)',
      edge: 'var(--ink-900)'
    }
  };
  const sizes = {
    sm: 34,
    md: 44,
    lg: 56
  };
  const p = palettes[variant] || palettes.cream;
  const d = sizes[size] || sizes.md;
  const press = (e, on) => {
    if (disabled) return;
    e.currentTarget.style.transform = on ? 'translate(2px,2px)' : 'translate(0,0)';
    e.currentTarget.style.boxShadow = on ? `1px 1px 0 ${p.edge}` : `3px 3px 0 ${p.edge}`;
  };
  return /*#__PURE__*/React.createElement("button", _extends({
    type: "button",
    "aria-label": label,
    disabled: disabled,
    onClick: disabled ? undefined : onClick,
    onMouseDown: e => press(e, true),
    onMouseUp: e => press(e, false),
    onMouseLeave: e => press(e, false),
    style: {
      display: 'inline-flex',
      alignItems: 'center',
      justifyContent: 'center',
      width: d,
      height: d,
      fontSize: d * 0.46,
      lineHeight: 1,
      color: p.fg,
      background: p.bg,
      border: 'var(--border-ink) solid var(--ink-900)',
      borderRadius: '50%',
      boxShadow: `3px 3px 0 ${p.edge}`,
      cursor: disabled ? 'not-allowed' : 'pointer',
      opacity: disabled ? 0.5 : 1,
      transition: 'var(--t-press)',
      padding: 0,
      ...style
    }
  }, rest), children);
}
Object.assign(__ds_scope, { IconButton });
})(); } catch (e) { __ds_ns.__errors.push({ path: "components/core/IconButton.jsx", error: String((e && e.message) || e) }); }

// components/core/MarginNote.jsx
try { (() => {
function _extends() { return _extends = Object.assign ? Object.assign.bind() : function (n) { for (var e = 1; e < arguments.length; e++) { var t = arguments[e]; for (var r in t) ({}).hasOwnProperty.call(t, r) && (n[r] = t[r]); } return n; }, _extends.apply(null, arguments); }
/**
 * MarginNote — a handwritten aside, like a margin scribble in a well-loved
 * textbook. Patrick Hand type, a slight tilt, and an optional push-pin.
 */
function MarginNote({
  children,
  tone = 'hat',
  tilt = -2,
  pin = true,
  style = {},
  ...rest
}) {
  const tones = {
    hat: {
      bg: 'var(--hat-100)',
      pin: 'var(--hat-700)'
    },
    coat: {
      bg: 'var(--coat-100)',
      pin: 'var(--coat-700)'
    },
    boots: {
      bg: 'var(--boots-100)',
      pin: 'var(--boots-700)'
    },
    leaf: {
      bg: 'var(--leaf-100)',
      pin: 'var(--leaf-700)'
    },
    sky: {
      bg: 'var(--sky-100)',
      pin: 'var(--sky-700)'
    }
  };
  const t = tones[tone] || tones.hat;
  return /*#__PURE__*/React.createElement("div", _extends({
    style: {
      position: 'relative',
      display: 'inline-block',
      maxWidth: '32ch',
      padding: '12px 16px',
      background: t.bg,
      border: 'var(--border-hair) solid var(--ink-900)',
      borderRadius: '4px 14px 8px 16px',
      fontFamily: 'var(--font-hand)',
      fontSize: 'var(--text-lg)',
      lineHeight: 'var(--leading-snug)',
      color: 'var(--ink-900)',
      transform: `rotate(${tilt}deg)`,
      boxShadow: 'var(--shadow-sm)',
      ...style
    }
  }, rest), pin && /*#__PURE__*/React.createElement("span", {
    "aria-hidden": "true",
    style: {
      position: 'absolute',
      top: -9,
      left: 16,
      width: 14,
      height: 14,
      borderRadius: '50%',
      background: t.pin,
      border: '2px solid var(--ink-900)',
      boxShadow: 'inset -2px -2px 0 rgba(0,0,0,0.18)'
    }
  }), children);
}
Object.assign(__ds_scope, { MarginNote });
})(); } catch (e) { __ds_ns.__errors.push({ path: "components/core/MarginNote.jsx", error: String((e && e.message) || e) }); }

// components/core/ProgressDots.jsx
try { (() => {
function _extends() { return _extends = Object.assign ? Object.assign.bind() : function (n) { for (var e = 1; e < arguments.length; e++) { var t = arguments[e]; for (var r in t) ({}).hasOwnProperty.call(t, r) && (n[r] = t[r]); } return n; }, _extends.apply(null, arguments); }
/**
 * ProgressDots — a page pager. Dots for each spread; the current one grows
 * into a stadium and fills with the brand hue.
 */
function ProgressDots({
  count = 5,
  current = 0,
  tone = 'coat',
  onSelect,
  style = {},
  ...rest
}) {
  const tones = {
    hat: 'var(--hat-500)',
    coat: 'var(--coat-500)',
    boots: 'var(--boots-500)',
    leaf: 'var(--leaf-500)'
  };
  const fill = tones[tone] || tones.coat;
  return /*#__PURE__*/React.createElement("div", _extends({
    role: "tablist",
    style: {
      display: 'inline-flex',
      alignItems: 'center',
      gap: '9px',
      ...style
    }
  }, rest), Array.from({
    length: count
  }).map((_, i) => {
    const active = i === current;
    return /*#__PURE__*/React.createElement("button", {
      key: i,
      role: "tab",
      "aria-selected": active,
      "aria-label": `Page ${i + 1}`,
      onClick: onSelect ? () => onSelect(i) : undefined,
      style: {
        width: active ? 30 : 14,
        height: 14,
        padding: 0,
        borderRadius: 'var(--radius-pill)',
        background: active ? fill : 'var(--paper-200)',
        border: '2px solid var(--ink-900)',
        cursor: onSelect ? 'pointer' : 'default',
        transition: 'width var(--dur-base) var(--ease-spring), background var(--dur-base) var(--ease-out)'
      }
    });
  }));
}
Object.assign(__ds_scope, { ProgressDots });
})(); } catch (e) { __ds_ns.__errors.push({ path: "components/core/ProgressDots.jsx", error: String((e && e.message) || e) }); }

// components/core/Switch.jsx
try { (() => {
function _extends() { return _extends = Object.assign ? Object.assign.bind() : function (n) { for (var e = 1; e < arguments.length; e++) { var t = arguments[e]; for (var r in t) ({}).hasOwnProperty.call(t, r) && (n[r] = t[r]); } return n; }, _extends.apply(null, arguments); }
/**
 * Switch — a chunky sticker toggle. Used as the layer on/off control in the
 * reader and anywhere a friendly boolean is needed.
 */
function Switch({
  checked = false,
  onChange,
  tone = 'leaf',
  disabled = false,
  label,
  id,
  style = {},
  ...rest
}) {
  const tones = {
    hat: 'var(--hat-500)',
    coat: 'var(--coat-500)',
    boots: 'var(--boots-500)',
    leaf: 'var(--leaf-500)',
    sky: 'var(--sky-500)'
  };
  const on = tones[tone] || tones.leaf;
  const track = {
    width: 52,
    height: 30,
    borderRadius: 'var(--radius-pill)',
    border: 'var(--border-ink) solid var(--ink-900)',
    background: checked ? on : 'var(--paper-200)',
    position: 'relative',
    flex: '0 0 auto',
    transition: 'background var(--dur-base) var(--ease-out)',
    cursor: disabled ? 'not-allowed' : 'pointer'
  };
  const thumb = {
    position: 'absolute',
    top: 2,
    left: checked ? 24 : 2,
    width: 22,
    height: 22,
    borderRadius: '50%',
    background: 'var(--cloud)',
    border: '2px solid var(--ink-900)',
    transition: 'left var(--dur-base) var(--ease-spring)',
    boxShadow: '1px 1px 0 rgba(46,36,24,0.35)'
  };
  const toggle = () => {
    if (!disabled && onChange) onChange(!checked);
  };
  return /*#__PURE__*/React.createElement("label", {
    htmlFor: id,
    style: {
      display: 'inline-flex',
      alignItems: 'center',
      gap: 'var(--space-3)',
      opacity: disabled ? 0.5 : 1,
      cursor: disabled ? 'not-allowed' : 'pointer',
      fontFamily: 'var(--font-body)',
      fontWeight: 'var(--w-semibold)',
      fontSize: 'var(--text-sm)',
      color: 'var(--ink-900)',
      ...style
    }
  }, /*#__PURE__*/React.createElement("button", _extends({
    id: id,
    type: "button",
    role: "switch",
    "aria-checked": checked,
    disabled: disabled,
    onClick: toggle,
    style: {
      ...track,
      padding: 0
    }
  }, rest), /*#__PURE__*/React.createElement("span", {
    style: thumb
  })), label && /*#__PURE__*/React.createElement("span", null, label));
}
Object.assign(__ds_scope, { Switch });
})(); } catch (e) { __ds_ns.__errors.push({ path: "components/core/Switch.jsx", error: String((e && e.message) || e) }); }

// components/reader/Callout.jsx
try { (() => {
/**
 * Callout — an encyclopedia-style label that points at a part of the scene.
 * Renders as SVG fragments (a leader line, an anchor dot, and a handwritten
 * label chip via <foreignObject>), so it MUST live inside a parent
 * <svg viewBox="0 0 1200 800"> overlay. Because it's inline SVG, the label
 * uses the real Patrick Hand webfont and stays pinned to the art at any scale.
 */
function Callout({
  ax,
  ay,
  // anchor point (where the dot sits, scene coords)
  lx,
  ly,
  // point where the leader meets the label
  side = 'right',
  // which way the label box grows from (lx,ly)
  width = 260,
  text,
  tone = 'hat',
  show = true
}) {
  const tones = {
    hat: {
      ink: 'var(--hat-900)',
      bg: '#FBE6BE',
      dot: 'var(--hat-500)'
    },
    coat: {
      ink: 'var(--coat-900)',
      bg: '#F4D2C2',
      dot: 'var(--coat-500)'
    },
    boots: {
      ink: 'var(--boots-900)',
      bg: '#D5DEDF',
      dot: 'var(--boots-500)'
    },
    leaf: {
      ink: 'var(--leaf-700)',
      bg: '#DCEBC8',
      dot: 'var(--leaf-500)'
    },
    sky: {
      ink: 'var(--sky-700)',
      bg: '#E4F1F7',
      dot: 'var(--sky-500)'
    }
  };
  const t = tones[tone] || tones.hat;
  const boxH = 130;
  const bx = side === 'left' ? lx - width : lx;
  const by = ly - boxH / 2;
  return /*#__PURE__*/React.createElement("g", {
    style: {
      opacity: show ? 1 : 0,
      transition: 'opacity 0.42s cubic-bezier(0.65, 0, 0.35, 1)',
      pointerEvents: 'none'
    }
  }, /*#__PURE__*/React.createElement("line", {
    x1: ax,
    y1: ay,
    x2: lx,
    y2: ly,
    stroke: "var(--ink-900)",
    strokeWidth: "2.5",
    strokeLinecap: "round",
    strokeDasharray: "2 7"
  }), /*#__PURE__*/React.createElement("circle", {
    cx: ax,
    cy: ay,
    r: "8",
    fill: t.dot,
    stroke: "var(--ink-900)",
    strokeWidth: "3"
  }), /*#__PURE__*/React.createElement("foreignObject", {
    x: bx,
    y: by,
    width: width,
    height: boxH
  }, /*#__PURE__*/React.createElement("div", {
    xmlns: "http://www.w3.org/1999/xhtml",
    style: {
      display: 'flex',
      height: '100%',
      alignItems: 'center',
      justifyContent: side === 'left' ? 'flex-end' : 'flex-start'
    }
  }, /*#__PURE__*/React.createElement("div", {
    style: {
      boxSizing: 'border-box',
      maxWidth: width,
      background: t.bg,
      color: 'var(--ink-900)',
      border: '2px solid var(--ink-900)',
      borderRadius: '4px 14px 8px 16px',
      padding: '8px 13px',
      fontFamily: 'var(--font-hand)',
      fontSize: 24,
      lineHeight: 1.12,
      boxShadow: '2px 2px 0 ' + t.ink,
      textAlign: side === 'left' ? 'right' : 'left'
    }
  }, text))));
}
Object.assign(__ds_scope, { Callout });
})(); } catch (e) { __ds_ns.__errors.push({ path: "components/reader/Callout.jsx", error: String((e && e.message) || e) }); }

// components/reader/LayerToggle.jsx
try { (() => {
function _extends() { return _extends = Object.assign ? Object.assign.bind() : function (n) { for (var e = 1; e < arguments.length; e++) { var t = arguments[e]; for (var r in t) ({}).hasOwnProperty.call(t, r) && (n[r] = t[r]); } return n; }, _extends.apply(null, arguments); }
/**
 * LayerToggle — one row in the reader's layer-control panel. A colored dot,
 * a label (and optional hint), and a Switch. This is the textbook
 * "transparency on/off" control.
 */
function LayerToggle({
  label,
  hint,
  tone = 'leaf',
  checked = false,
  onChange,
  locked = false,
  style = {},
  ...rest
}) {
  const dotColor = {
    hat: 'var(--hat-500)',
    coat: 'var(--coat-500)',
    boots: 'var(--boots-500)',
    leaf: 'var(--leaf-500)',
    sky: 'var(--sky-500)'
  }[tone] || 'var(--leaf-500)';
  return /*#__PURE__*/React.createElement("div", _extends({
    style: {
      display: 'flex',
      alignItems: 'center',
      gap: 'var(--space-3)',
      padding: '10px 12px',
      background: checked ? 'var(--surface-card)' : 'var(--surface-sunk)',
      border: 'var(--border-hair) solid var(--ink-900)',
      borderRadius: 'var(--radius-md)',
      boxShadow: checked ? '2px 2px 0 var(--ink-900)' : 'none',
      transition: 'background var(--dur-base) var(--ease-out), box-shadow var(--dur-base) var(--ease-out)',
      opacity: locked ? 0.55 : 1,
      ...style
    }
  }, rest), /*#__PURE__*/React.createElement("span", {
    style: {
      width: 14,
      height: 14,
      borderRadius: '50%',
      flex: '0 0 auto',
      background: dotColor,
      border: '2px solid var(--ink-900)'
    }
  }), /*#__PURE__*/React.createElement("span", {
    style: {
      flex: 1,
      minWidth: 0
    }
  }, /*#__PURE__*/React.createElement("span", {
    style: {
      display: 'block',
      fontFamily: 'var(--font-display)',
      fontWeight: 'var(--w-medium)',
      fontSize: 'var(--text-md)',
      color: 'var(--ink-900)',
      lineHeight: 1.1
    }
  }, label), hint && /*#__PURE__*/React.createElement("span", {
    style: {
      display: 'block',
      fontFamily: 'var(--font-hand)',
      fontSize: 'var(--text-sm)',
      color: 'var(--ink-500)',
      marginTop: 2
    }
  }, hint)), /*#__PURE__*/React.createElement(__ds_scope.Switch, {
    checked: checked,
    onChange: onChange,
    tone: tone,
    disabled: locked
  }));
}
Object.assign(__ds_scope, { LayerToggle });
})(); } catch (e) { __ds_ns.__errors.push({ path: "components/reader/LayerToggle.jsx", error: String((e && e.message) || e) }); }

// components/reader/OverlayStage.jsx
try { (() => {
function _extends() { return _extends = Object.assign ? Object.assign.bind() : function (n) { for (var e = 1; e < arguments.length; e++) { var t = arguments[e]; for (var r in t) ({}).hasOwnProperty.call(t, r) && (n[r] = t[r]); } return n; }, _extends.apply(null, arguments); }
/**
 * OverlayStage — the heart of Hat, Coat & Boots. A stack of transparent SVG
 * layers that fade in and out like the acetate overlays in an old
 * encyclopedia. Each layer is a part of the house; toggling them builds the
 * house up (or peels it back) one piece at a time.
 *
 * Uncontrolled by default — pass `visible` + `onChange` to control it.
 */
function OverlayStage({
  layers = [],
  visible,
  defaultVisible,
  onChange,
  showControls = true,
  controlsTitle = 'Peel the layers',
  ratio = '4 / 3',
  caption,
  style = {},
  ...rest
}) {
  const isControlled = Array.isArray(visible);
  const initial = defaultVisible || layers.filter(l => l.locked || l.on !== false).map(l => l.id);
  const [internal, setInternal] = React.useState(initial);
  const shown = isControlled ? visible : internal;
  const toggle = (id, next) => {
    const set = new Set(shown);
    if (next) set.add(id);else set.delete(id);
    const arr = layers.filter(l => set.has(l.id)).map(l => l.id);
    if (!isControlled) setInternal(arr);
    if (onChange) onChange(arr);
  };
  return /*#__PURE__*/React.createElement("div", _extends({
    style: {
      display: 'grid',
      gridTemplateColumns: showControls ? 'minmax(0,1fr) clamp(190px, 26%, 250px)' : '1fr',
      gap: 'var(--space-5)',
      alignItems: 'start',
      ...style
    }
  }, rest), /*#__PURE__*/React.createElement("div", null, /*#__PURE__*/React.createElement("div", {
    style: {
      position: 'relative',
      aspectRatio: ratio,
      width: '100%',
      background: 'var(--sky-100)',
      border: 'var(--border-ink) solid var(--ink-900)',
      borderRadius: 'var(--radius-lg)',
      boxShadow: 'var(--shadow-card)',
      overflow: 'hidden'
    }
  }, layers.map(l => {
    const on = shown.includes(l.id);
    return /*#__PURE__*/React.createElement("img", {
      key: l.id,
      src: l.src,
      alt: on ? l.alt || `${l.label} layer` : '',
      "aria-hidden": on ? undefined : 'true',
      style: {
        position: 'absolute',
        inset: 0,
        width: '100%',
        height: '100%',
        objectFit: 'contain',
        opacity: on ? 1 : 0,
        transform: on ? 'translateY(0)' : 'translateY(6px)',
        transition: 'var(--t-layer)',
        pointerEvents: 'none'
      }
    });
  })), caption && /*#__PURE__*/React.createElement("p", {
    style: {
      margin: 'var(--space-3) 0 0',
      fontFamily: 'var(--font-hand)',
      fontSize: 'var(--text-lg)',
      color: 'var(--ink-500)',
      textAlign: 'center'
    }
  }, caption)), showControls && /*#__PURE__*/React.createElement("div", {
    style: {
      display: 'flex',
      flexDirection: 'column',
      gap: 'var(--space-3)'
    }
  }, /*#__PURE__*/React.createElement("div", {
    style: {
      fontFamily: 'var(--font-display)',
      fontWeight: 'var(--w-semibold)',
      fontSize: 'var(--text-md)',
      color: 'var(--ink-700)',
      textTransform: 'uppercase',
      letterSpacing: 'var(--tracking-label)'
    }
  }, controlsTitle), layers.map(l => /*#__PURE__*/React.createElement(__ds_scope.LayerToggle, {
    key: l.id,
    label: l.label,
    hint: l.hint,
    tone: l.tone,
    locked: l.locked,
    checked: shown.includes(l.id),
    onChange: next => toggle(l.id, next)
  }))));
}
Object.assign(__ds_scope, { OverlayStage });
})(); } catch (e) { __ds_ns.__errors.push({ path: "components/reader/OverlayStage.jsx", error: String((e && e.message) || e) }); }

// ui_kits/series-site/Hero.jsx
try { (() => {
/* global React */
// Hero — big promise + interactive layered house to play with.

const HERO_LAYERS = [{
  id: 'world',
  label: 'The World',
  tone: 'leaf',
  locked: true,
  src: '../../assets/layers/book1/world.svg',
  hint: 'sky & ground'
}, {
  id: 'boots',
  label: 'The Boots',
  tone: 'boots',
  src: '../../assets/layers/book1/boots.svg',
  hint: 'foundation'
}, {
  id: 'coat',
  label: 'The Coat',
  tone: 'coat',
  src: '../../assets/layers/book1/coat.svg',
  hint: 'walls'
}, {
  id: 'hat',
  label: 'The Hat',
  tone: 'hat',
  src: '../../assets/layers/book1/hat.svg',
  hint: 'roof'
}];
function Hero() {
  const {
    Button,
    Chip,
    MarginNote,
    OverlayStage
  } = window.HatCoatBootsDesignSystem_0d0e5a;
  return /*#__PURE__*/React.createElement("section", {
    id: "top",
    style: {
      display: 'grid',
      gridTemplateColumns: 'minmax(0,1fr) minmax(0,1.05fr)',
      gap: 'clamp(24px, 5vw, 64px)',
      alignItems: 'center',
      padding: 'clamp(36px, 6vw, 80px) clamp(16px, 5vw, 56px)',
      maxWidth: 'var(--container-wide)',
      margin: '0 auto'
    }
  }, /*#__PURE__*/React.createElement("div", null, /*#__PURE__*/React.createElement(Chip, {
    tone: "hat",
    dot: false
  }, "A natural-building story for kids"), /*#__PURE__*/React.createElement("h1", {
    style: {
      margin: 'var(--space-4) 0 var(--space-4)',
      fontFamily: 'var(--font-display)',
      fontWeight: 700,
      fontSize: 'clamp(40px, 6vw, 72px)',
      lineHeight: 1.04,
      letterSpacing: '-0.02em',
      color: 'var(--ink-900)'
    }
  }, "Every house wears a ", /*#__PURE__*/React.createElement("span", {
    style: {
      color: 'var(--hat-700)'
    }
  }, "hat"), ", a ", /*#__PURE__*/React.createElement("span", {
    style: {
      color: 'var(--coat-700)'
    }
  }, "coat"), ", & ", /*#__PURE__*/React.createElement("span", {
    style: {
      color: 'var(--boots-700)'
    }
  }, "boots"), "."), /*#__PURE__*/React.createElement("p", {
    style: {
      margin: '0 0 var(--space-5)',
      fontFamily: 'var(--font-body)',
      fontSize: 'var(--text-lg)',
      lineHeight: 'var(--leading-normal)',
      color: 'var(--ink-700)',
      maxWidth: '46ch'
    }
  }, "A gentle, hands-on picture book that teaches kids how a real house keeps warm and dry \u2014 built from straw, stone and sunshine. Peel the layers and build it yourself."), /*#__PURE__*/React.createElement("div", {
    style: {
      display: 'flex',
      gap: 'var(--space-3)',
      alignItems: 'center',
      flexWrap: 'wrap'
    }
  }, /*#__PURE__*/React.createElement(Button, {
    variant: "coat",
    size: "lg",
    iconLeft: "\uD83D\uDCD6",
    href: "../storybook-reader/index.html"
  }, "Start reading"), /*#__PURE__*/React.createElement(Button, {
    variant: "cream",
    size: "lg"
  }, "Meet the series")), /*#__PURE__*/React.createElement("div", {
    style: {
      marginTop: 'var(--space-5)'
    }
  }, /*#__PURE__*/React.createElement(MarginNote, {
    tone: "leaf",
    tilt: -2
  }, "Free to read online \u2014 no signup, no ads. \u2600\uFE0F"))), /*#__PURE__*/React.createElement("div", null, /*#__PURE__*/React.createElement(OverlayStage, {
    layers: HERO_LAYERS,
    controlsTitle: "Build it!",
    caption: "Flip the switches to build the house \u2192"
  })));
}
Object.assign(window, {
  Hero
});
})(); } catch (e) { __ds_ns.__errors.push({ path: "ui_kits/series-site/Hero.jsx", error: String((e && e.message) || e) }); }

// ui_kits/series-site/HowItWorks.jsx
try { (() => {
/* global React */
// HowItWorks — explains the layered overlay idea + the cradle-to-cradle heart.

const STEPS = [{
  dot: 'var(--leaf-500)',
  emoji: '🌍',
  title: 'Start with the world',
  text: 'Sun, air, water and ground come first — just like a real builder studies a site before drawing a single line.'
}, {
  dot: 'var(--boots-500)',
  emoji: '🥾',
  title: 'Add a layer at a time',
  text: 'Boots, then coat, then hat. Each transparent layer fades in over the last, so the house assembles itself as the story is read.'
}, {
  dot: 'var(--hat-500)',
  emoji: '🎩',
  title: 'Peek inside any time',
  text: 'Flip a layer off to see what is underneath. Curiosity is the whole point — there is no wrong way to explore.'
}];
function HowItWorks() {
  const {
    Card,
    Chip
  } = window.HatCoatBootsDesignSystem_0d0e5a;
  return /*#__PURE__*/React.createElement("section", {
    style: {
      background: 'var(--paper-100)',
      borderTop: 'var(--border-ink) solid var(--ink-900)',
      borderBottom: 'var(--border-ink) solid var(--ink-900)'
    }
  }, /*#__PURE__*/React.createElement("div", {
    style: {
      padding: 'clamp(36px, 5vw, 72px) clamp(16px, 5vw, 56px)',
      maxWidth: 'var(--container-wide)',
      margin: '0 auto'
    }
  }, /*#__PURE__*/React.createElement("div", {
    style: {
      textAlign: 'center',
      marginBottom: 'var(--space-7)'
    }
  }, /*#__PURE__*/React.createElement(Chip, {
    tone: "sky",
    dot: false
  }, "Like an encyclopedia overlay"), /*#__PURE__*/React.createElement("h2", {
    style: {
      margin: 'var(--space-3) 0 0',
      fontFamily: 'var(--font-display)',
      fontWeight: 700,
      fontSize: 'clamp(30px, 4vw, 46px)',
      color: 'var(--ink-900)'
    }
  }, "Built in see-through layers")), /*#__PURE__*/React.createElement("div", {
    style: {
      display: 'grid',
      gridTemplateColumns: 'repeat(auto-fit, minmax(250px, 1fr))',
      gap: 'var(--space-5)',
      marginBottom: 'var(--space-7)'
    }
  }, STEPS.map(s => /*#__PURE__*/React.createElement(Card, {
    key: s.title,
    tone: "cream"
  }, /*#__PURE__*/React.createElement("div", {
    style: {
      fontSize: 34,
      marginBottom: 'var(--space-2)'
    }
  }, s.emoji), /*#__PURE__*/React.createElement("h3", {
    style: {
      margin: '0 0 var(--space-2)',
      fontFamily: 'var(--font-display)',
      fontWeight: 600,
      fontSize: 'var(--text-lg)',
      color: 'var(--ink-900)'
    }
  }, s.title), /*#__PURE__*/React.createElement("p", {
    style: {
      margin: 0,
      fontFamily: 'var(--font-body)',
      fontSize: 'var(--text-md)',
      lineHeight: 'var(--leading-normal)',
      color: 'var(--ink-700)'
    }
  }, s.text)))), /*#__PURE__*/React.createElement(Card, {
    tone: "leaf",
    pad: "lg",
    style: {
      maxWidth: 760,
      margin: '0 auto'
    }
  }, /*#__PURE__*/React.createElement("div", {
    style: {
      fontFamily: 'var(--font-hand)',
      fontSize: 'var(--text-lg)',
      color: 'var(--leaf-700)',
      marginBottom: 4
    }
  }, "For the grown-ups"), /*#__PURE__*/React.createElement("h3", {
    style: {
      margin: '0 0 var(--space-3)',
      fontFamily: 'var(--font-display)',
      fontWeight: 700,
      fontSize: 'var(--text-2xl)',
      color: 'var(--ink-900)'
    }
  }, "Somewhere between Bob Ross, Mister Rogers & This Old House."), /*#__PURE__*/React.createElement("p", {
    style: {
      margin: 0,
      fontFamily: 'var(--font-body)',
      fontSize: 'var(--text-lg)',
      lineHeight: 'var(--leading-normal)',
      color: 'var(--ink-700)'
    }
  }, "The series is grounded in cradle-to-cradle design \u2014 the idea that a building should give back like a tree: clean air, clean water, healthy soil. Materials are either ", /*#__PURE__*/React.createElement("b", null, "biological"), " (they return to the earth) or ", /*#__PURE__*/React.createElement("b", null, "technical"), "(they cycle forever). We just say it with straw bales, rain barrels and a warm, patient voice."))));
}
Object.assign(window, {
  HowItWorks
});
})(); } catch (e) { __ds_ns.__errors.push({ path: "ui_kits/series-site/HowItWorks.jsx", error: String((e && e.message) || e) }); }

// ui_kits/series-site/SeriesShelf.jsx
try { (() => {
/* global React */
// SeriesShelf — the three books in the series, as little cover cards.

const BOOKS = [{
  n: 1,
  title: 'Hat, Coat & Boots',
  sub: 'roof, walls & foundation',
  cover: 'var(--hat-300)',
  status: 'Out now',
  parts: ['Hat', 'Coat', 'Boots'],
  live: true
}, {
  n: 2,
  title: 'Water, Waste & Electricity',
  sub: 'rain barrels, composting toilets, solar & windmills',
  cover: 'var(--sky-300)',
  status: 'Coming soon',
  parts: ['Water', 'Waste', 'Power']
}, {
  n: 3,
  title: 'A Tiny House on Wheels',
  sub: 'build it all on a double-axle trailer',
  cover: 'var(--leaf-300)',
  status: 'In the workshop',
  parts: ['Trailer', 'Frame', 'Home']
}];
function BookCover({
  book
}) {
  const {
    Chip,
    Button
  } = window.HatCoatBootsDesignSystem_0d0e5a;
  return /*#__PURE__*/React.createElement("article", {
    style: {
      display: 'flex',
      flexDirection: 'column',
      background: 'var(--surface-card)',
      border: 'var(--border-ink) solid var(--ink-900)',
      borderRadius: 'var(--radius-lg)',
      boxShadow: 'var(--shadow-card)',
      overflow: 'hidden'
    }
  }, /*#__PURE__*/React.createElement("div", {
    style: {
      position: 'relative',
      aspectRatio: '4 / 3',
      background: book.cover,
      borderBottom: 'var(--border-ink) solid var(--ink-900)',
      display: 'flex',
      alignItems: 'center',
      justifyContent: 'center'
    }
  }, /*#__PURE__*/React.createElement("img", {
    src: "../../assets/brand/mark.svg",
    alt: "",
    style: {
      width: '46%',
      maxWidth: 150
    }
  }), /*#__PURE__*/React.createElement("span", {
    style: {
      position: 'absolute',
      top: 12,
      left: 12,
      fontFamily: 'var(--font-display)',
      fontWeight: 700,
      fontSize: 'var(--text-sm)',
      background: 'var(--ink-900)',
      color: 'var(--paper-50)',
      padding: '3px 10px',
      borderRadius: 'var(--radius-pill)'
    }
  }, "Book ", book.n)), /*#__PURE__*/React.createElement("div", {
    style: {
      padding: 'var(--space-5)',
      display: 'flex',
      flexDirection: 'column',
      gap: 'var(--space-3)',
      flex: 1
    }
  }, /*#__PURE__*/React.createElement("h3", {
    style: {
      margin: 0,
      fontFamily: 'var(--font-display)',
      fontWeight: 700,
      fontSize: 'var(--text-xl)',
      color: 'var(--ink-900)',
      lineHeight: 1.15
    }
  }, book.title), /*#__PURE__*/React.createElement("p", {
    style: {
      margin: 0,
      fontFamily: 'var(--font-hand)',
      fontSize: 'var(--text-lg)',
      color: 'var(--coat-700)'
    }
  }, book.sub), /*#__PURE__*/React.createElement("div", {
    style: {
      display: 'flex',
      gap: 6,
      flexWrap: 'wrap',
      marginTop: 'auto'
    }
  }, book.parts.map(p => /*#__PURE__*/React.createElement(Chip, {
    key: p,
    tone: "neutral",
    dot: false,
    size: "sm"
  }, p))), /*#__PURE__*/React.createElement("div", {
    style: {
      display: 'flex',
      alignItems: 'center',
      justifyContent: 'space-between',
      gap: 8,
      marginTop: 'var(--space-2)'
    }
  }, /*#__PURE__*/React.createElement(Chip, {
    tone: book.live ? 'leaf' : 'hat',
    dot: true
  }, book.status), book.live ? /*#__PURE__*/React.createElement(Button, {
    variant: "coat",
    size: "sm",
    href: "../storybook-reader/index.html"
  }, "Read") : /*#__PURE__*/React.createElement(Button, {
    variant: "cream",
    size: "sm"
  }, "Notify me"))));
}
function SeriesShelf() {
  const {
    Chip
  } = window.HatCoatBootsDesignSystem_0d0e5a;
  return /*#__PURE__*/React.createElement("section", {
    style: {
      padding: 'clamp(36px, 5vw, 72px) clamp(16px, 5vw, 56px)',
      maxWidth: 'var(--container-wide)',
      margin: '0 auto'
    }
  }, /*#__PURE__*/React.createElement("div", {
    style: {
      textAlign: 'center',
      marginBottom: 'var(--space-7)'
    }
  }, /*#__PURE__*/React.createElement(Chip, {
    tone: "boots",
    dot: false
  }, "The series"), /*#__PURE__*/React.createElement("h2", {
    style: {
      margin: 'var(--space-3) 0 0',
      fontFamily: 'var(--font-display)',
      fontWeight: 700,
      fontSize: 'clamp(30px, 4vw, 46px)',
      color: 'var(--ink-900)'
    }
  }, "Three books. One growing house.")), /*#__PURE__*/React.createElement("div", {
    style: {
      display: 'grid',
      gridTemplateColumns: 'repeat(auto-fit, minmax(280px, 1fr))',
      gap: 'var(--space-5)'
    }
  }, BOOKS.map(b => /*#__PURE__*/React.createElement(BookCover, {
    key: b.n,
    book: b
  }))));
}
Object.assign(window, {
  SeriesShelf
});
})(); } catch (e) { __ds_ns.__errors.push({ path: "ui_kits/series-site/SeriesShelf.jsx", error: String((e && e.message) || e) }); }

// ui_kits/series-site/SiteApp.jsx
try { (() => {
/* global React */
function SiteApp() {
  return /*#__PURE__*/React.createElement("div", {
    style: {
      background: 'var(--surface-page)'
    }
  }, /*#__PURE__*/React.createElement(window.SiteHeader, null), /*#__PURE__*/React.createElement(window.Hero, null), /*#__PURE__*/React.createElement(window.SeriesShelf, null), /*#__PURE__*/React.createElement(window.HowItWorks, null), /*#__PURE__*/React.createElement(window.SiteFooter, null));
}
Object.assign(window, {
  SiteApp
});
})(); } catch (e) { __ds_ns.__errors.push({ path: "ui_kits/series-site/SiteApp.jsx", error: String((e && e.message) || e) }); }

// ui_kits/series-site/SiteFooter.jsx
try { (() => {
/* global React */
// SiteFooter — quiet close with the brand mark and the source nod.
function SiteFooter() {
  return /*#__PURE__*/React.createElement("footer", {
    style: {
      background: 'var(--ink-900)',
      color: 'var(--paper-100)',
      padding: 'clamp(32px, 4vw, 56px) clamp(16px, 5vw, 56px)'
    }
  }, /*#__PURE__*/React.createElement("div", {
    style: {
      maxWidth: 'var(--container-wide)',
      margin: '0 auto',
      display: 'flex',
      gap: 'var(--space-6)',
      flexWrap: 'wrap',
      alignItems: 'center',
      justifyContent: 'space-between'
    }
  }, /*#__PURE__*/React.createElement("div", {
    style: {
      display: 'flex',
      alignItems: 'center',
      gap: 12
    }
  }, /*#__PURE__*/React.createElement("img", {
    src: "../../assets/brand/mark.svg",
    alt: "",
    style: {
      width: 44,
      height: 44
    }
  }), /*#__PURE__*/React.createElement("div", null, /*#__PURE__*/React.createElement("div", {
    style: {
      fontFamily: 'var(--font-display)',
      fontWeight: 700,
      fontSize: 'var(--text-lg)'
    }
  }, "Hat, Coat & Boots"), /*#__PURE__*/React.createElement("div", {
    style: {
      fontFamily: 'var(--font-hand)',
      fontSize: 'var(--text-md)',
      color: 'var(--hat-300)'
    }
  }, "a house-building story for curious kids"))), /*#__PURE__*/React.createElement("nav", {
    style: {
      display: 'flex',
      gap: 'var(--space-5)',
      fontFamily: 'var(--font-body)',
      fontSize: 'var(--text-sm)'
    }
  }, /*#__PURE__*/React.createElement("a", {
    href: "#",
    style: {
      color: 'var(--paper-200)',
      textDecoration: 'none'
    }
  }, "The books"), /*#__PURE__*/React.createElement("a", {
    href: "#",
    style: {
      color: 'var(--paper-200)',
      textDecoration: 'none'
    }
  }, "Classroom guide"), /*#__PURE__*/React.createElement("a", {
    href: "#",
    style: {
      color: 'var(--paper-200)',
      textDecoration: 'none'
    }
  }, "Read aloud"), /*#__PURE__*/React.createElement("a", {
    href: "#",
    style: {
      color: 'var(--paper-200)',
      textDecoration: 'none'
    }
  }, "Contact"))));
}
Object.assign(window, {
  SiteFooter
});
})(); } catch (e) { __ds_ns.__errors.push({ path: "ui_kits/series-site/SiteFooter.jsx", error: String((e && e.message) || e) }); }

// ui_kits/series-site/SiteHeader.jsx
try { (() => {
/* global React */
// SiteHeader — marketing site top nav.

function SiteHeader() {
  const {
    Button
  } = window.HatCoatBootsDesignSystem_0d0e5a;
  const links = ['The Books', 'How it works', 'For grown-ups'];
  return /*#__PURE__*/React.createElement("header", {
    style: {
      position: 'sticky',
      top: 0,
      zIndex: 10,
      display: 'flex',
      alignItems: 'center',
      gap: 'var(--space-5)',
      padding: '12px clamp(16px, 5vw, 56px)',
      background: 'var(--surface-card)',
      borderBottom: 'var(--border-ink) solid var(--ink-900)'
    }
  }, /*#__PURE__*/React.createElement("a", {
    href: "#top",
    style: {
      display: 'flex',
      alignItems: 'center',
      gap: 10,
      textDecoration: 'none'
    }
  }, /*#__PURE__*/React.createElement("img", {
    src: "../../assets/brand/mark.svg",
    alt: "",
    style: {
      width: 40,
      height: 40
    }
  }), /*#__PURE__*/React.createElement("span", {
    style: {
      fontFamily: 'var(--font-display)',
      fontWeight: 700,
      fontSize: 'var(--text-lg)',
      color: 'var(--ink-900)'
    }
  }, "Hat, Coat & Boots")), /*#__PURE__*/React.createElement("nav", {
    style: {
      display: 'flex',
      gap: 'var(--space-5)',
      marginLeft: 'auto'
    }
  }, links.map(l => /*#__PURE__*/React.createElement("a", {
    key: l,
    href: "#",
    style: {
      fontFamily: 'var(--font-display)',
      fontWeight: 500,
      fontSize: 'var(--text-md)',
      color: 'var(--ink-700)',
      textDecoration: 'none'
    }
  }, l))), /*#__PURE__*/React.createElement(Button, {
    variant: "coat",
    size: "sm",
    iconRight: "\uD83D\uDCD6"
  }, "Read free"));
}
Object.assign(window, {
  SiteHeader
});
})(); } catch (e) { __ds_ns.__errors.push({ path: "ui_kits/series-site/SiteHeader.jsx", error: String((e && e.message) || e) }); }

// ui_kits/storybook-reader/BeatPanel.jsx
try { (() => {
/* global React */
// BeatPanel — one narrative beat. A frosted "paper" card pinned to the left
// that stays centered while its scroll section passes through, carrying the
// real story text, an optional cutaway figure, and a margin note.
function BeatPanel({
  beat,
  index,
  active
}) {
  const {
    MarginNote,
    Chip
  } = window.HatCoatBootsDesignSystem_0d0e5a;
  const paras = beat.body.split('\n\n');
  const isCover = index === 0;
  return /*#__PURE__*/React.createElement("div", {
    style: {
      position: 'sticky',
      top: 'clamp(70px, 13vh, 130px)',
      width: 'min(440px, 40vw)',
      minWidth: 296,
      marginLeft: 'clamp(16px, 4vw, 64px)',
      background: 'rgba(251, 246, 236, 0.94)',
      backdropFilter: 'blur(5px)',
      WebkitBackdropFilter: 'blur(5px)',
      border: 'var(--border-ink) solid var(--ink-900)',
      borderRadius: 'var(--radius-lg)',
      boxShadow: 'var(--shadow-pop)',
      padding: 'var(--space-5) var(--space-6)',
      display: 'flex',
      flexDirection: 'column',
      gap: 'var(--space-3)',
      opacity: active ? 1 : 0.5,
      transition: 'opacity 0.4s ease',
      pointerEvents: 'auto'
    }
  }, /*#__PURE__*/React.createElement("div", {
    style: {
      display: 'flex',
      alignItems: 'center',
      gap: 10
    }
  }, isCover ? /*#__PURE__*/React.createElement("img", {
    src: "../../assets/brand/mark.svg",
    alt: "",
    style: {
      width: 30,
      height: 30
    }
  }) : /*#__PURE__*/React.createElement("span", {
    style: {
      fontFamily: 'var(--font-display)',
      fontWeight: 600,
      fontSize: 'var(--text-xs)',
      textTransform: 'uppercase',
      letterSpacing: 'var(--tracking-label)',
      color: 'var(--coat-700)'
    }
  }, beat.act), isCover && /*#__PURE__*/React.createElement("span", {
    style: {
      fontFamily: 'var(--font-display)',
      fontWeight: 600,
      fontSize: 'var(--text-xs)',
      textTransform: 'uppercase',
      letterSpacing: 'var(--tracking-label)',
      color: 'var(--ink-300)'
    }
  }, "A house-building story")), /*#__PURE__*/React.createElement("h1", {
    style: {
      margin: 0,
      fontFamily: 'var(--font-display)',
      fontWeight: 700,
      fontSize: isCover ? 'clamp(30px, 3.4vw, 44px)' : 'clamp(24px, 2.6vw, 34px)',
      lineHeight: 'var(--leading-snug)',
      color: 'var(--ink-900)'
    }
  }, beat.title), paras.map((p, i) => /*#__PURE__*/React.createElement("p", {
    key: i,
    style: {
      margin: 0,
      fontFamily: 'var(--font-body)',
      fontSize: 'var(--text-lg)',
      lineHeight: 'var(--leading-relax)',
      color: 'var(--ink-700)'
    }
  }, p)), beat.detail && /*#__PURE__*/React.createElement("figure", {
    style: {
      margin: 0,
      display: 'flex',
      alignItems: 'center',
      gap: 'var(--space-3)',
      background: 'var(--surface-card)',
      border: 'var(--border-hair) solid var(--ink-900)',
      borderRadius: 'var(--radius-md)',
      padding: 'var(--space-3)'
    }
  }, /*#__PURE__*/React.createElement("img", {
    src: beat.detail,
    alt: beat.detailCaption,
    style: {
      width: 92,
      height: 70,
      flex: '0 0 auto'
    }
  }), /*#__PURE__*/React.createElement("figcaption", {
    style: {
      fontFamily: 'var(--font-hand)',
      fontSize: 'var(--text-md)',
      color: 'var(--coat-700)',
      lineHeight: 1.25
    }
  }, /*#__PURE__*/React.createElement(Chip, {
    tone: "boots",
    dot: false,
    size: "sm",
    style: {
      marginBottom: 5
    }
  }, "Cutaway"), /*#__PURE__*/React.createElement("div", null, beat.detailCaption))), beat.note && /*#__PURE__*/React.createElement("div", {
    style: {
      alignSelf: 'flex-start'
    }
  }, /*#__PURE__*/React.createElement(MarginNote, {
    tone: beat.note.tone || 'hat',
    tilt: beat.note.tilt ?? -2
  }, beat.note.text)));
}
Object.assign(window, {
  BeatPanel
});
})(); } catch (e) { __ds_ns.__errors.push({ path: "ui_kits/storybook-reader/BeatPanel.jsx", error: String((e && e.message) || e) }); }

// ui_kits/storybook-reader/ReaderApp.jsx
try { (() => {
/* global React */
// ReaderApp — the scrollytelling storybook. A fixed house sits behind a column
// of scroll sections, one per narrative beat. As each beat reaches the center
// of the screen it becomes active, building the house another layer. Prev/next
// and a play button scroll between beats; a progress rail jumps to any act.
function ReaderApp() {
  const {
    IconButton
  } = window.HatCoatBootsDesignSystem_0d0e5a;
  const BEATS = window.HCB_BEATS;
  const LAYERS = window.HCB_LAYERS;
  const [active, setActive] = React.useState(0);
  const [playing, setPlaying] = React.useState(false);
  const refs = React.useRef([]);
  const activeRef = React.useRef(0);
  activeRef.current = active;

  // Active beat = the section whose center is nearest the viewport center.
  React.useEffect(() => {
    let last = 0;
    const measure = () => {
      const vc = window.innerHeight / 2;
      let best = 0,
        bd = Infinity;
      refs.current.forEach((el, i) => {
        if (!el) return;
        const r = el.getBoundingClientRect();
        const d = Math.abs(r.top + r.height / 2 - vc);
        if (d < bd) {
          bd = d;
          best = i;
        }
      });
      setActive(best);
    };
    const onScroll = () => {
      const now = Date.now();
      if (now - last < 40) return;
      last = now;
      measure();
    };
    window.addEventListener('scroll', onScroll, {
      passive: true
    });
    window.addEventListener('resize', measure);
    measure();
    return () => {
      window.removeEventListener('scroll', onScroll);
      window.removeEventListener('resize', measure);
    };
  }, []);
  const goTo = React.useCallback(i => {
    const el = refs.current[i];
    if (!el) return;
    const top = el.offsetTop + el.offsetHeight / 2 - window.innerHeight / 2;
    window.scrollTo({
      top,
      behavior: 'smooth'
    });
  }, []);

  // Read-along playback: advance a beat every 7s, stop at the end.
  React.useEffect(() => {
    if (!playing) return undefined;
    const t = setInterval(() => {
      const next = activeRef.current + 1;
      if (next >= BEATS.length) {
        setPlaying(false);
        return;
      }
      goTo(next);
    }, 7000);
    return () => clearInterval(t);
  }, [playing, BEATS.length, goTo]);
  const beat = BEATS[active];

  // Group beats into acts for the progress rail.
  const acts = [];
  BEATS.forEach((b, i) => {
    const last = acts[acts.length - 1];
    if (last && last.act === b.act) last.idxs.push(i);else acts.push({
      act: b.act,
      idxs: [i]
    });
  });
  const floatBar = {
    background: 'rgba(251, 246, 236, 0.94)',
    backdropFilter: 'blur(4px)',
    WebkitBackdropFilter: 'blur(4px)',
    border: 'var(--border-ink) solid var(--ink-900)',
    borderRadius: 'var(--radius-pill)',
    boxShadow: 'var(--shadow-pop)'
  };
  return /*#__PURE__*/React.createElement("div", null, /*#__PURE__*/React.createElement(window.SceneStage, {
    layers: LAYERS,
    visible: beat.visible,
    spotlight: beat.spotlight,
    callouts: beat.callouts
  }), /*#__PURE__*/React.createElement("div", {
    style: {
      position: 'relative',
      zIndex: 2
    }
  }, BEATS.map((b, i) => /*#__PURE__*/React.createElement("section", {
    key: i,
    ref: el => {
      refs.current[i] = el;
    },
    style: {
      minHeight: '94vh',
      display: 'flex',
      alignItems: 'flex-start'
    }
  }, /*#__PURE__*/React.createElement(window.BeatPanel, {
    beat: b,
    index: i,
    active: i === active
  })))), /*#__PURE__*/React.createElement("nav", {
    "aria-label": "Chapters",
    style: {
      position: 'fixed',
      top: '50%',
      right: 'clamp(10px, 1.6vw, 22px)',
      transform: 'translateY(-50%)',
      zIndex: 20,
      display: 'flex',
      flexDirection: 'column',
      gap: 'var(--space-3)',
      alignItems: 'flex-end'
    }
  }, acts.map(a => {
    const on = a.idxs.includes(active);
    return /*#__PURE__*/React.createElement("div", {
      key: a.act,
      style: {
        display: 'flex',
        alignItems: 'center',
        gap: 8
      }
    }, /*#__PURE__*/React.createElement("span", {
      style: {
        fontFamily: 'var(--font-display)',
        fontWeight: 600,
        fontSize: 'var(--text-xs)',
        color: on ? 'var(--ink-900)' : 'var(--ink-300)',
        opacity: on ? 1 : 0,
        transition: 'opacity 0.3s ease',
        whiteSpace: 'nowrap'
      }
    }, a.act), /*#__PURE__*/React.createElement("div", {
      style: {
        display: 'flex',
        gap: 4
      }
    }, a.idxs.map(i => /*#__PURE__*/React.createElement("button", {
      key: i,
      onClick: () => goTo(i),
      "aria-label": 'Go to ' + BEATS[i].title,
      style: {
        width: i === active ? 22 : 9,
        height: 9,
        padding: 0,
        borderRadius: 'var(--radius-pill)',
        background: i === active ? 'var(--coat-500)' : on ? 'var(--coat-300)' : 'var(--paper-300)',
        border: '2px solid var(--ink-900)',
        cursor: 'pointer',
        transition: 'width 0.25s var(--ease-spring), background 0.25s ease'
      }
    }))));
  })), /*#__PURE__*/React.createElement("div", {
    style: {
      position: 'fixed',
      bottom: 'clamp(16px, 3vh, 28px)',
      left: '50%',
      transform: 'translateX(-50%)',
      zIndex: 20,
      display: 'flex',
      alignItems: 'center',
      gap: 'var(--space-4)',
      ...floatBar,
      padding: '10px 18px'
    }
  }, /*#__PURE__*/React.createElement(IconButton, {
    variant: "cream",
    size: "sm",
    label: "Previous page",
    onClick: () => {
      setPlaying(false);
      goTo(Math.max(0, active - 1));
    },
    disabled: active === 0
  }, "\u2190"), /*#__PURE__*/React.createElement(IconButton, {
    variant: playing ? 'coat' : 'hat',
    label: playing ? 'Pause read-along' : 'Play read-along',
    onClick: () => {
      if (active >= BEATS.length - 1) goTo(0);
      setPlaying(p => !p);
    }
  }, playing ? '❚❚' : '▶'), /*#__PURE__*/React.createElement(IconButton, {
    variant: "cream",
    size: "sm",
    label: "Next page",
    onClick: () => {
      setPlaying(false);
      goTo(Math.min(BEATS.length - 1, active + 1));
    },
    disabled: active === BEATS.length - 1
  }, "\u2192"), /*#__PURE__*/React.createElement("span", {
    style: {
      width: 1,
      alignSelf: 'stretch',
      background: 'var(--line-soft)',
      margin: '0 2px'
    }
  }), /*#__PURE__*/React.createElement("span", {
    style: {
      fontFamily: 'var(--font-display)',
      fontWeight: 600,
      fontSize: 'var(--text-sm)',
      color: 'var(--ink-500)',
      whiteSpace: 'nowrap'
    }
  }, active + 1, " / ", BEATS.length)), /*#__PURE__*/React.createElement("div", {
    style: {
      position: 'fixed',
      bottom: 'clamp(74px, 12vh, 104px)',
      left: '50%',
      transform: 'translateX(-50%)',
      zIndex: 19,
      fontFamily: 'var(--font-hand)',
      fontSize: 'var(--text-lg)',
      color: 'var(--ink-700)',
      opacity: active === 0 ? 0.9 : 0,
      transition: 'opacity 0.4s ease',
      pointerEvents: 'none'
    }
  }, "scroll to build the house \u2193"));
}
Object.assign(window, {
  ReaderApp
});
})(); } catch (e) { __ds_ns.__errors.push({ path: "ui_kits/storybook-reader/ReaderApp.jsx", error: String((e && e.message) || e) }); }

// ui_kits/storybook-reader/ReaderData.jsx
try { (() => {
/* global window */
// Book 1 data for the storybook reader: the transparent layer stack (paint
// order, bottom→top) and the beat-by-beat narrative. Each beat ADDS layers,
// so the house accretes as you read. Spotlights, callouts and cutaway insets
// are pinned in 1200×800 scene coordinates.
(function () {
  const S = '../../assets/scenes/cottage/';

  // Paint order — every layer that can appear, bottom to top.
  const LAYERS = ['sky', 'sun', 'clouds', 'hills', 'ground', 'foliage', 'trench', 'gravel', 'footing', 'sill', 'frame', 'rafters', 'bales', 'plaster', 'openings', 'thatch', 'ridge', 'chimney', 'smoke', 'birds'].map(id => ({
    id,
    src: S + id + '.svg'
  }));
  const WORLD = ['sky', 'sun', 'clouds', 'hills', 'ground', 'foliage', 'birds'];
  const BEATS = [{
    act: 'Welcome',
    title: 'Hat, Coat & Boots',
    add: WORLD,
    body: "Every house wears three things, just the way you do. A hat up top to keep off the rain. A warm coat all around to hold in the cozy. And sturdy boots down below, so its feet stay dry.\n\nCome along, neighbor — let's build one together, from the ground all the way up to the sky.",
    note: {
      tone: 'leaf',
      text: 'Scroll down to start building ↓'
    }
  }, {
    act: 'The World',
    title: 'First, the world',
    add: [],
    body: "Before a single board is cut, a good builder just sits a while and watches. Where does the morning sun come up? Which way does the wind like to blow?",
    spotlight: {
      cx: 600,
      cy: 120,
      r: 230
    },
    callouts: [{
      ax: 600,
      ay: 120,
      lx: 770,
      ly: 70,
      side: 'right',
      tone: 'hat',
      text: 'The sun warms it for free'
    }]
  }, {
    act: 'The World',
    title: 'A good spot',
    add: [],
    body: "We pick a gentle rise with the big tree off to the west — shade for hot afternoons, and open sky to the south for all that lovely light. The land always tells you where the house wants to stand.",
    spotlight: {
      cx: 1040,
      cy: 470,
      r: 240
    },
    callouts: [{
      ax: 1040,
      ay: 470,
      lx: 880,
      ly: 560,
      side: 'left',
      tone: 'leaf',
      text: 'The tree gives afternoon shade'
    }]
  }, {
    act: 'The Boots',
    title: 'Boots first',
    add: ['trench'],
    body: "Now we dig. Down through the soft topsoil to the firm earth below, we open a tidy trench right where the walls will stand. Every good pair of boots starts with solid ground.",
    spotlight: {
      cx: 735,
      cy: 660,
      r: 240
    },
    callouts: [{
      ax: 735,
      ay: 692,
      lx: 870,
      ly: 724,
      side: 'right',
      tone: 'boots',
      text: 'Dig down to firm earth'
    }]
  }, {
    act: 'The Boots',
    title: 'A bed of stone',
    add: ['gravel'],
    body: "Into the trench goes a deep bed of gravel. When the rain sinks down, it trickles away through all the little gaps — so water never pools where the house likes to keep dry.",
    callouts: [{
      ax: 735,
      ay: 672,
      lx: 900,
      ly: 706,
      side: 'right',
      tone: 'boots',
      text: 'Gravel lets the rain drain away'
    }]
  }, {
    act: 'The Boots',
    title: 'Boots of stone',
    add: ['footing'],
    body: "On the gravel we stack a low wall of river stone: the footing. Like rubber boots in a puddle, it lifts the whole house up out of the wet. No soggy feet for this little home.",
    detail: S + 'detail-footing.svg',
    detailCaption: 'Gravel drains · stone lifts · sill stays dry',
    callouts: [{
      ax: 825,
      ay: 622,
      lx: 925,
      ly: 560,
      side: 'right',
      tone: 'boots',
      text: 'Dry-stacked river stone'
    }],
    note: {
      tone: 'boots',
      text: 'Stone wicks no water!'
    }
  }, {
    act: 'The Boots',
    title: 'Laced up tight',
    add: ['sill'],
    body: "Across the top we lay a timber sill, with a slim strip beneath to stop any damp from sneaking up. The boots are laced. The house has good, dry feet to stand on.",
    callouts: [{
      ax: 885,
      ay: 580,
      lx: 930,
      ly: 520,
      side: 'right',
      tone: 'coat',
      text: 'Sill plate — nothing wet gets past'
    }]
  }, {
    act: 'The Coat',
    title: 'Now the bones',
    add: ['frame'],
    body: "Up go the posts and beams — a frame of honest timber, pegged together at the corners with wooden pegs. No nails needed. These are the bones the warm coat will hang upon.",
    spotlight: {
      cx: 735,
      cy: 470,
      r: 250
    },
    callouts: [{
      ax: 735,
      ay: 470,
      lx: 930,
      ly: 430,
      side: 'right',
      tone: 'coat',
      text: 'Pegged timber frame: the bones'
    }]
  }, {
    act: 'The Coat',
    title: 'A coat of straw',
    add: ['bales'],
    body: "Between the posts we tuck thick golden bales of straw, packed in tight, row upon row. Straw is full of tiny pockets of trapped air — and trapped air is wonderfully good at keeping warmth right where you want it.",
    detail: S + 'detail-wall.svg',
    detailCaption: 'Plaster · straw core · timber post · plaster',
    callouts: [{
      ax: 660,
      ay: 474,
      lx: 930,
      ly: 470,
      side: 'right',
      tone: 'hat',
      text: 'Straw bales: a coat full of cozy air'
    }],
    note: {
      tone: 'coat',
      text: 'Straw bales are great insulation!',
      tilt: -3
    }
  }, {
    act: 'The Coat',
    title: 'A breathable skin',
    add: ['plaster'],
    body: "Over the straw we smooth a coat of earthen plaster, inside and out. It guards the straw from the weather, yet still lets the wall breathe — like a good raincoat that never gets stuffy.",
    callouts: [{
      ax: 850,
      ay: 520,
      lx: 930,
      ly: 560,
      side: 'right',
      tone: 'coat',
      text: 'Earthen plaster breathes'
    }]
  }, {
    act: 'The Coat',
    title: 'Eyes and a smile',
    add: ['openings'],
    body: "We cut openings for windows, to let the sunshine wander room to room, and a friendly front door to welcome everyone home. Now the house has eyes, and a smile.",
    callouts: [{
      ax: 825,
      ay: 462,
      lx: 930,
      ly: 420,
      side: 'right',
      tone: 'sky',
      text: 'Windows for light, a door for friends'
    }]
  }, {
    act: 'The Hat',
    title: 'Raising the rafters',
    add: ['rafters'],
    body: "High above the walls, pairs of rafters lean in and shake hands at the ridge. A sturdy collar tie holds them steady — like folded arms resting across the top of the house.",
    spotlight: {
      cx: 735,
      cy: 290,
      r: 260
    },
    callouts: [{
      ax: 735,
      ay: 290,
      lx: 935,
      ly: 250,
      side: 'right',
      tone: 'coat',
      text: 'Rafters shake hands at the ridge'
    }]
  }, {
    act: 'The Hat',
    title: 'A hat of thatch',
    add: ['thatch'],
    body: "Now the hat itself: bundle after golden bundle of thatch, combed smooth so the rain runs straight off. The wide brim hangs out past the walls, throwing every drop well clear.",
    detail: S + 'detail-roof.svg',
    detailCaption: 'Thatch over rafters sheds rain off the brim',
    callouts: [{
      ax: 905,
      ay: 330,
      lx: 948,
      ly: 288,
      side: 'right',
      tone: 'hat',
      text: 'Wide brim throws the rain clear'
    }],
    note: {
      tone: 'hat',
      text: 'A thatch roof can last for decades!',
      tilt: 2
    }
  }, {
    act: 'The Hat',
    title: 'A living roof',
    add: ['ridge'],
    body: "Right along the ridge we tuck in a little garden of green. It sips the rain, it feeds the bees, and it gives the birds a fine high place to sit and gossip.",
    callouts: [{
      ax: 735,
      ay: 196,
      lx: 905,
      ly: 150,
      side: 'right',
      tone: 'leaf',
      text: 'A living roof for the bees 🐝'
    }]
  }, {
    act: 'The Hat',
    title: 'A cozy chimney',
    add: ['chimney', 'smoke'],
    body: "Up pops a stout little chimney for the woodstove. So on chilly evenings, a soft curl of smoke can drift up and wave hello to the very first stars.",
    callouts: [{
      ax: 833,
      ay: 250,
      lx: 948,
      ly: 212,
      side: 'right',
      tone: 'boots',
      text: "Smoke says: someone's home"
    }]
  }, {
    act: 'Home',
    title: 'Hat, coat, and boots',
    add: [],
    body: "And there it stands. Boots of stone, a warm coat of straw and plaster, and a fine thatched hat up top. Snug in winter, cool in summer, and dry in every storm that blows.",
    callouts: [{
      ax: 735,
      ay: 250,
      lx: 948,
      ly: 165,
      side: 'right',
      tone: 'hat',
      width: 120,
      text: 'Hat'
    }, {
      ax: 895,
      ay: 470,
      lx: 950,
      ly: 470,
      side: 'right',
      tone: 'coat',
      width: 130,
      text: 'Coat'
    }, {
      ax: 820,
      ay: 612,
      lx: 948,
      ly: 662,
      side: 'right',
      tone: 'boots',
      width: 140,
      text: 'Boots'
    }]
  }, {
    act: 'Home',
    title: 'Built to give back',
    add: [],
    body: "Best of all, this little house is kind. The straw and timber and earth will all return to the soil one day, clean as they came — while the house gives back shade, and shelter, and a home full of warm evenings.\n\nThat's how we build, neighbor. Next time: water, waste, and electricity.",
    note: {
      tone: 'leaf',
      text: 'Book 2 is coming soon!'
    }
  }];

  // Precompute cumulative visible layer ids for each beat.
  let acc = [];
  BEATS.forEach(b => {
    acc = acc.concat(b.add || []);
    b.visible = acc.slice();
  });
  window.HCB_LAYERS = LAYERS;
  window.HCB_BEATS = BEATS;
})();
})(); } catch (e) { __ds_ns.__errors.push({ path: "ui_kits/storybook-reader/ReaderData.jsx", error: String((e && e.message) || e) }); }

// ui_kits/storybook-reader/SceneStage.jsx
try { (() => {
function _extends() { return _extends = Object.assign ? Object.assign.bind() : function (n) { for (var e = 1; e < arguments.length; e++) { var t = arguments[e]; for (var r in t) ({}).hasOwnProperty.call(t, r) && (n[r] = t[r]); } return n; }, _extends.apply(null, arguments); }
/* global React */
// SceneStage — the fixed, full-viewport house. All layers are always mounted;
// the active beat decides which are visible (they fade in as you scroll). A
// spotlight gently dims everything outside the part being discussed, and the
// callouts + their leader lines live in an inline SVG so they stay pinned to
// the art at any size.
function SceneStage({
  layers,
  visible,
  spotlight,
  callouts
}) {
  const {
    Callout
  } = window.HatCoatBootsDesignSystem_0d0e5a;
  return /*#__PURE__*/React.createElement("div", {
    style: {
      position: 'fixed',
      inset: 0,
      overflow: 'hidden',
      background: 'var(--sky-100)'
    }
  }, layers.map(l => /*#__PURE__*/React.createElement("img", {
    key: l.id,
    src: l.src,
    alt: "",
    "aria-hidden": "true",
    style: {
      position: 'absolute',
      inset: 0,
      width: '100%',
      height: '100%',
      objectFit: 'cover',
      objectPosition: 'center 60%',
      opacity: visible.includes(l.id) ? 1 : 0,
      transition: 'opacity 0.6s ease'
    }
  })), /*#__PURE__*/React.createElement("svg", {
    viewBox: "0 0 1200 800",
    preserveAspectRatio: "xMidYMid slice",
    style: {
      position: 'absolute',
      inset: 0,
      width: '100%',
      height: '100%',
      overflow: 'visible',
      pointerEvents: 'none'
    }
  }, spotlight && /*#__PURE__*/React.createElement("g", {
    style: {
      transition: 'opacity 0.5s ease'
    }
  }, /*#__PURE__*/React.createElement("defs", null, /*#__PURE__*/React.createElement("radialGradient", {
    id: "hcb-spot",
    gradientUnits: "userSpaceOnUse",
    cx: spotlight.cx,
    cy: spotlight.cy,
    r: spotlight.r
  }, /*#__PURE__*/React.createElement("stop", {
    offset: "0.5",
    stopColor: "#2E2418",
    stopOpacity: "0"
  }), /*#__PURE__*/React.createElement("stop", {
    offset: "1",
    stopColor: "#2E2418",
    stopOpacity: "0.4"
  }))), /*#__PURE__*/React.createElement("rect", {
    x: "0",
    y: "0",
    width: "1200",
    height: "800",
    fill: "url(#hcb-spot)"
  })), (callouts || []).map((c, i) => /*#__PURE__*/React.createElement(Callout, _extends({
    key: i
  }, c, {
    show: true
  })))));
}
Object.assign(window, {
  SceneStage
});
})(); } catch (e) { __ds_ns.__errors.push({ path: "ui_kits/storybook-reader/SceneStage.jsx", error: String((e && e.message) || e) }); }

__ds_ns.Badge = __ds_scope.Badge;

__ds_ns.Button = __ds_scope.Button;

__ds_ns.Card = __ds_scope.Card;

__ds_ns.Chip = __ds_scope.Chip;

__ds_ns.IconButton = __ds_scope.IconButton;

__ds_ns.MarginNote = __ds_scope.MarginNote;

__ds_ns.ProgressDots = __ds_scope.ProgressDots;

__ds_ns.Switch = __ds_scope.Switch;

__ds_ns.Callout = __ds_scope.Callout;

__ds_ns.LayerToggle = __ds_scope.LayerToggle;

__ds_ns.OverlayStage = __ds_scope.OverlayStage;

})();
