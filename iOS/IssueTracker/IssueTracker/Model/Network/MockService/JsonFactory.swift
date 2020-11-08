//
//  JsonFactory.swift
//  IssueTracker
//
//  Created by a1111 on 2020/11/09.
//

import Foundation

protocol JsonFactory {
    func loadJson(endPoint: EndPointable) -> Data?
}

struct JsonFactoryFalse: JsonFactory {
    func loadJson(endPoint: EndPointable) -> Data? {
        switch endPoint {
        case BackEndAPI.allIssues:
            return """
                    "id": 1,
                    "title": "회원가입 기능 구현",
                    "status": "closed",
                    "createdAt": "2020-10-28 00:00:00",
                    "updatedAt": "2020-11-08 19:27:40",
                    "deletedAt": null,
                    "user_id": 5,
                    "milestone_id": null,
            """.data(using: .utf8)
        default:
            return nil
        }
    }
}

struct JsonFactoryTrue: JsonFactory {
    
    func loadJson(endPoint: EndPointable) -> Data? {
        switch endPoint {
        case BackEndAPI.allIssues:
            return """
            [
                {
                    "id": 1,
                    "title": "회원가입 기능 구현",
                    "status": "closed",
                    "createdAt": "2020-10-28 00:00:00",
                    "updatedAt": "2020-11-08 19:27:40",
                    "deletedAt": null,
                    "user_id": 5,
                    "milestone_id": null,
                    "labels": [
                        {
                            "id": 1,
                            "name": "frontend",
                            "description": "",
                            "color": "#000000"
                        },
                        {
                            "id": 2,
                            "name": "backend",
                            "description": "",
                            "color": "#cccccc"
                        }
                    ],
                    "assignees": [],
                    "author": {
                        "id": 5,
                        "user_id": "98778990",
                        "photo_url": null,
                        "type": "github"
                    },
                    "comments": [],
                    "milestone": {
                            "id": 1,
                            "title": "1주차",
                            "due_date": "2020-11-03"
                    }
                },
                {
                    "id": 2,
                    "title": "로그인 기능 구현",
                    "status": "open",
                    "createdAt": "2020-10-28 00:00:00",
                    "updatedAt": "2020-10-28 00:00:00",
                    "deletedAt": null,
                    "user_id": 5,
                    "milestone_id": null,
                    "labels": [
                        {
                            "id": 1,
                            "name": "frontend",
                            "description": "",
                            "color": "#000000"
                        },
                        {
                            "id": 2,
                            "name": "backend",
                            "description": "",
                            "color": "#cccccc"
                        }
                    ],
                    "assignees": [],
                    "author": {
                        "id": 5,
                        "user_id": "98778990",
                        "photo_url": null,
                        "type": "github"
                    },
                    "comments": [],
                    "milestone": null
                },
                {
                    "id": 3,
                    "title": "로그아웃 기능 구현",
                    "status": "open",
                    "createdAt": "2020-10-28 00:00:00",
                    "updatedAt": "2020-10-28 00:00:00",
                    "deletedAt": null,
                    "user_id": 5,
                    "milestone_id": null,
                    "labels": [
                        {
                            "id": 1,
                            "name": "frontend",
                            "description": "",
                            "color": "#000000"
                        }
                    ],
                    "assignees": [],
                    "author": {
                        "id": 5,
                        "user_id": "98778990",
                        "photo_url": null,
                        "type": "github"
                    },
                    "comments": [],
                    "milestone": null
                },
                {
                    "id": 4,
                    "title": "깃허브 로그인 기능 구현",
                    "status": "open",
                    "createdAt": "2020-10-28 00:00:00",
                    "updatedAt": "2020-10-28 00:00:00",
                    "deletedAt": null,
                    "user_id": 5,
                    "milestone_id": null,
                    "labels": [],
                    "assignees": [],
                    "author": {
                        "id": 5,
                        "user_id": "98778990",
                        "photo_url": null,
                        "type": "github"
                    },
                    "comments": [],
                    "milestone": null
                },
                {
                    "id": 5,
                    "title": "이슈 생성 기능 구현",
                    "status": "open",
                    "createdAt": "2020-10-28 00:00:00",
                    "updatedAt": "2020-10-28 00:00:00",
                    "deletedAt": null,
                    "user_id": 5,
                    "milestone_id": null,
                    "labels": [],
                    "assignees": [],
                    "author": {
                        "id": 5,
                        "user_id": "98778990",
                        "photo_url": null,
                        "type": "github"
                    },
                    "comments": [],
                    "milestone": null
                },
                {
                    "id": 6,
                    "title": "이슈 조회 기능 구현",
                    "status": "open",
                    "createdAt": "2020-10-28 00:00:00",
                    "updatedAt": "2020-10-28 00:00:00",
                    "deletedAt": null,
                    "user_id": 5,
                    "milestone_id": null,
                    "labels": [],
                    "assignees": [],
                    "author": {
                        "id": 5,
                        "user_id": "98778990",
                        "photo_url": null,
                        "type": "github"
                    },
                    "comments": [],
                    "milestone": null
                },
                {
                    "id": 7,
                    "title": "이슈 생성 기능 구현",
                    "status": "open",
                    "createdAt": "2020-10-28 00:00:00",
                    "updatedAt": "2020-10-28 00:00:00",
                    "deletedAt": null,
                    "user_id": 5,
                    "milestone_id": null,
                    "labels": [],
                    "assignees": [],
                    "author": {
                        "id": 5,
                        "user_id": "98778990",
                        "photo_url": null,
                        "type": "github"
                    },
                    "comments": [],
                    "milestone": null
                },
                {
                    "id": 8,
                    "title": "이슈 필터 기능 구현",
                    "status": "open",
                    "createdAt": "2020-10-28 00:00:00",
                    "updatedAt": "2020-10-28 00:00:00",
                    "deletedAt": null,
                    "user_id": 5,
                    "milestone_id": null,
                    "labels": [],
                    "assignees": [],
                    "author": {
                        "id": 5,
                        "user_id": "98778990",
                        "photo_url": null,
                        "type": "github"
                    },
                    "comments": [],
                    "milestone": null
                }
            ]
            """.data(using: .utf8)
        default:
            return nil
        }
    }
}
