# =========================
# AWS WAF Web ACL for ALB
# =========================

resource "aws_wafv2_web_acl" "alb_waf" {
  name        = "todo-alb-waf"
  description = "WAF protection for Todo API ALB"
  scope       = "REGIONAL"

  default_action {
    allow {}
  }

  # -------------------------
  # AWS Managed Common Rules
  # -------------------------
  rule {
    name     = "AWSManagedRulesCommonRuleSet"
    priority = 1

    override_action {
      none {}
    }

    statement {
      managed_rule_group_statement {
        name        = "AWSManagedRulesCommonRuleSet"
        vendor_name = "AWS"
      }
    }

    visibility_config {
      cloudwatch_metrics_enabled = true
      metric_name                = "AWSManagedRulesCommonRuleSet"
      sampled_requests_enabled   = true
    }
  }

  # -------------------------
  # Known Bad Inputs
  # -------------------------
  rule {
    name     = "AWSManagedRulesKnownBadInputsRuleSet"
    priority = 2

    override_action {
      none {}
    }

    statement {
      managed_rule_group_statement {
        name        = "AWSManagedRulesKnownBadInputsRuleSet"
        vendor_name = "AWS"
      }
    }

    visibility_config {
      cloudwatch_metrics_enabled = true
      metric_name                = "AWSManagedRulesKnownBadInputsRuleSet"
      sampled_requests_enabled   = true
    }
  }

  # -------------------------
  # SQL Injection Protection
  # -------------------------
  rule {
    name     = "AWSManagedRulesSQLiRuleSet"
    priority = 3

    override_action {
      none {}
    }

    statement {
      managed_rule_group_statement {
        name        = "AWSManagedRulesSQLiRuleSet"
        vendor_name = "AWS"
      }
    }

    visibility_config {
      cloudwatch_metrics_enabled = true
      metric_name                = "AWSManagedRulesSQLiRuleSet"
      sampled_requests_enabled   = true
    }
  }

  # -------------------------
  # Rate Limiting
  # -------------------------
  rule {
    name     = "RateLimitRule"
    priority = 4

    action {
      block {}
    }

    statement {
      rate_based_statement {
        limit              = 2000
        aggregate_key_type = "IP"
      }
    }

    visibility_config {
      cloudwatch_metrics_enabled = true
      metric_name                = "RateLimitRule"
      sampled_requests_enabled   = true
    }
  }

  # -------------------------
  # Web ACL Visibility
  # -------------------------
  visibility_config {
    cloudwatch_metrics_enabled = true
    metric_name                = "todo-alb-waf"
    sampled_requests_enabled   = true
  }

  tags = {
    Name        = "todo-alb-waf"
    Environment = "staging"
  }
}

# =========================
# Associate WAF with ALB
# =========================

resource "aws_wafv2_web_acl_association" "alb_waf_association" {
  resource_arn = aws_lb.ALB.arn
  web_acl_arn  = aws_wafv2_web_acl.alb_waf.arn
}

