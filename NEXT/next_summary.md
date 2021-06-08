## Create a Next.js App
---

### ����
``` next
npx create-next-app
```

### ����
```next
npm run dev
```

### ���ο� ������ ����
 * pages ������ ���ο� js ������ ����
   * ex) pages/posts/first-post.js
   * http://localhost:3000/posts/first-post
``` next
export default function FirstPost() { �� �Լ��̸��� ����� ����
    return <h1>First Post</h1>
}
```

## Navigate Between Pages
---
### ����
 * Link ������Ʈ�� Next.js ���� ������ ����  client-side-navigation�� �����ϰ� ��
 * �ڹٽ�ũ��Ʈ�� ���ؼ� ������ ��ȯ�� �ϱ� ������ ������ �⺻ �׺���̼Ǻ��� ������.
 * ������ �̵��ÿ� refresh�� ����.

### import
``` next
import Link from 'next/link'
```

### ����
 * a �±� ��ſ� Link �±׸� ����Ѵ�.
 * a �±״� Link �±� �ȿ��� ��ũ�� �����ش�.
``` next
<h1 className="title">
  Read{' '} �� ' ' ��ĭ�� a�±׿��� ����
  <Link href="/posts/first-post"> 
    <a>this page!</a>
  </Link>
</h1>
```
 * �ε��� �������� ���� ��ũ
``` next
<div className="container">
  <h1>First Post</h1>
  <Link href="/"> �� index��� ���� �ʿ� ����.
    <a>Back to home</a>
  </Link>
</div>
```

### Code Splitting and prefetching
 * Next.js�� code splitting�� **�ڵ�**���� �����Ѵ�.
 * �׷��� �������� render �� �� �ʿ��� ������ �ܿ��� �ʱ�ȭ ���� �ʴ´�.
 * �� �������� isolated �Ǿ��ֱ� ������ �� ���������� ������ ���� ������ ���ø����̼��� �����۵��Ѵ�.
 * Link �±׷� ����� �������� prefetch �Ǳ� ������ ������ �̵��� �� �ִ�.
 
### Note
 * ���� Next.js �� �ܺ��� �������� �����ϰ� �ʹٸ� ������ a �±׸� �̵�
 * a �±��� className �Ӽ��� �̿��ϰ� �ʹٸ� �Ʒ��� ���� ���
``` next
<Link href="/">
  <a className="foo" target="_blank" rel="noopener noreferrer">
    Hello World
  </a>
</Link>
```

## Assets, Metadata, and CSS
---

### ����
 * Next.js �� built-in CSS�� ����

### Assets
 * Next.js�� public ���� �Ʒ��� �̹��� ���� ���� ��Ҹ� ����.
 * public ���� �Ʒ��� ���ϵ��� ���ø����̼ǿ��� �����ȴ�.
 
#### Image

##### ����
 * Next.js�� Image �±״� �ֽ� �������� Ȯ��� next/imageHTML img����̴�.
 * ���������� �����ϴ� ��� JPEG���� �� 30 % ���� **WebP**�� ���� �ֽ� �̹��� �������� �̹����� �ڵ����� �����Ѵ�.(�ʿ信 ���� �̹��� ����ȭ)
 * ����Ʈ�� ��ũ���ϴ� ���� Ư�� �Ӱ� ���� ���� �� ��쿡�� ������ ������ �̹����� �����ε��Ѵ�.
 * �������� ����� �پ��� �� ����� ���� �ػ󵵿� ���� �ٸ� �̹��� ũ�⸦ ������ �� �ִ�.
 * ������ ǰ���� 75 %�� ������ ���� �Ӱ� ������ �ڵ� �����Ѵ�(�� ȣ�⿡ ���� ���� ����)

##### Import
``` next
import Image from 'next/image'
```
##### ���
``` next
<Image
  src="/images/profile.jpg"
  height={144} width={144} alt="woogie"
/>
```

### Metadata

#### Head
 * ����Ʈ������ head �±� ��ſ� Head �±׸� ���

##### Import
``` next
import Head from 'next/head'
```

##### ���
``` next
<Head>
  <title>First Post</title>
</Head>
```

### CSS Styling

#### style jsx

##### style �±�
``` next
<style jsx>{`
  ...
`}</style>
```

#### CSS ���� ���� �� import
 * �ݵ�� �̸��� ���ϸ�.module.css �� ����

##### layout.module.css
``` next
.container {
    max-width: 36rem;
    padding: 0 1rem;
    margin: 3rem auto 6rem;
}
```

##### layout.js
 * className={styles.container}
   * styles�� module.css ������ import�� �� ������ �̸�
   * container�� module.css ���Ͽ��� ������ Ŭ���� ��
``` next
import styles from './layout.module.css'

export default function Layout({ children }) {
  return (
    <div className={styles.container}>
      {children}
    </div>
  )
}
```

##### first-post.js
 * Layout �±� ������ ��ҵ��� layout.js�� default�Լ��� ���� layout�� ���� ä�� ���´�.
``` next
import Layout from '../../components/layout'

export default function FirstPost() {
  return (
  <Layout>
    <Head>
      <title>First Post</title>
    </Head>
    <h1>First Post</h1>
    <Link href="/">
      <a>Back to home</a>
    </Link>
    <Image
      src="/images/profile.jpg"
      height={144} width={144} alt="woogie"
    />
  </Layout>
  )
}
```

#### Global Styles
 * ��� �������� ���� CSS ������ �ε�Ǳ� ���Ѵٸ� ���
 * index.js�� ���� ������ _app.js ����(�̸�����)
   * ���� �Ŀ��� �ݵ�� ������ ������ �ٽ� �÷�����
     * `npm run dev`

##### _app.js
``` next
import '../styles/global.css'

export default function App({ Component, pageProps }) {
  return <Component {...pageProps} />
}	 
```

##### global.css
``` next
html,
body {
  padding: 0;
  margin: 0;
  font-family: -apple-system, BlinkMacSystemFont, Segoe UI, Roboto, Oxygen, Ubuntu,
    Cantarell, Fira Sans, Droid Sans, Helvetica Neue, sans-serif;
  line-height: 1.6;
  font-size: 18px;
}

* {
  box-sizing: border-box;
}

a {
  color: #0070f3;
  text-decoration: none;
}

a:hover {
  text-decoration: underline;
}

img {
  max-width: 100%;
  display: block;
}
```

## Pre-rendering and Data Fetching
---

### Pre-rendering
 * Next.js�� �������� �ε� �Ǹ� ��� �������� pre-render�Ѵ�.
 * ������ HTML�� �ּ����� �ʿ��� �ڹٽ�ũ��Ʈ �ڵ尡 ���ԵǾ� �־� ȭ���� ������ ����.
 * �� �Ŀ� �ڹٽ�ũ��Ʈ�� �۵��ϸ鼭 fully interactive�ϰ� �Ѵ�. 
 * �̸� hydration�̶�� �Ѵ�.
 * Next�� ������� ���� React ���̶�� pre-render�� �������� ����
 * �� ���������� Static Generation �Ǵ� Server-side Rendering�� ���� ����
  
#### Static Generation
 * build time�� HTML�� �����ϰ� ������ request���� ���� �Ǵ� ���
 * �̸� �������� ������ �α� ������ ����ڸ��� �������� generate�� �ʿ䰡 ��������.
 * ��ǰ ������, ��α� �Խù�, ���� ���� ������ �������� ����ϸ� ����.

##### getStaticProps
 * async �Լ��� �ܺ� ���� �ý��ۿ��� �����͸� ������
 * pre-render�ÿ� �����͵� �Բ� render�ϰ� ��
 * �̴� build time�� ���� ���� �����
 * �۵� �ñ�
   * In development (npm run dev or yarn dev), getStaticProps runs on every request.
   * In production, getStaticProps runs at build time. 
 * only be exported from a page. You can��t export it from non-page files.

##### gray-matter
 * ������ ��Ÿ������(ex. title, date ��)�� YAML Front Matter��� �θ���.
 * �̸� parsing �ϱ� ���� ���̺귯���� gray-matter
``` next
npm install gray-matter
```

##### path
 * nextjs-blog
   * lib
     * posts.js
   * pages
     * index.js
   * posts
     * pre-rendering.md
	 * ssg-ssr.md

##### posts.js
``` next
import fs from 'fs'
import path from 'path'
import matter from 'gray-matter'

�� process.cwd(): node����� ȣ���� �۾����͸��� ������
�� �Ķ���ͷ� ���� ��ε��� �ϳ��� ���ļ� ���ڿ� ���·� path�� ����
const postsDirectory = path.join(process.cwd(), 'posts')

export function getSortedPostsData() {
  �� /posts ���� �Ʒ��� ���� �̸��� �о����
  const fileNames = fs.readdirSync(postsDirectory)
  
  �� ���ϵ��� �����͸� �о�鿩 Ư�� �����͸� �迭�� ������(map �Լ� ����)
  const allPostsData = fileNames.map(fileName => {
    �� Ȯ���� .md�� ���� �̸��� id�� ��
    const id = fileName.replace(/\.md$/, '')

    �� �����̸��� ������ ��ü��θ� ������ ����
    const fullPath = path.join(postsDirectory, fileName)
	
    �� ������ �����͸� �о� �鿩 ����
    const fileContents = fs.readFileSync(fullPath, 'utf8')

    �� gray-matter�� ����ؼ� metadata section �κ��� �Ľ�
    const matterResult = matter(fileContents)

    �� id ���� gray-matter�� ����� �� ��Ÿ�����͸� ���ļ� ��ȯ
    �� id, title, date
    return {
      id,
      ...matterResult.data
    }
  })
  
  �� ������ ���� ������ �迭�� �ֽ� ������ �����Ͽ� ����
  return allPostsData.sort((a, b) => {
    if (a.date < b.date) {
      return 1
    } else {
      return -1
    }
  })
}
```

##### index.js
``` next
import Head from 'next/head'
import Layout, { siteTitle } from '../components/layout'
import utilStyles from '../styles/utils.module.css'

�� posts.js�κ��� getSortedPostsData() �Լ��� �ҷ�����
import { getSortedPostsData } from '../lib/posts'

export async function getStaticProps() {

  �� getSortedPostsData() �Լ��� ���� {id, title, date} �����͸� ���Ϲ���
  const allPostsData = getSortedPostsData()
  return {
    props: {
      allPostsData
    }
  }
}

export default function Home({ allPostsData }) {
  return (
    <Layout home>
      <Head>
        <title>{siteTitle}</title>
      </Head>
      <section className={utilStyles.headingMd}>
        <p>[Your Self Introduction]</p>
        <p>
          (This is a sample website - you��ll be building a site like this on{' '}
          <a href="https://nextjs.org/learn">our Next.js tutorial</a>.)
        </p>
      </section>

      <section className={`${utilStyles.headingMd} ${utilStyles.padding1px}`}>
        <h2 className={utilStyles.headingLg}>Blog</h2>
        <ul className={utilStyles.list}>
          �� allPostsData�� id, date, title ���� �̾� ����Ʈ ���
		  �� utilStyles�� CSS
          {allPostsData.map(({ id, date, title }) => (
            <li className={utilStyles.listItem} key={id}>
              {title}
              <br />
              {id}
              <br />
              {date}
            </li>
          ))}
        </ul>
      </section>
    </Layout>
  )
}
```

##### Fetch External API or Query Database
 * �ܺ� API�� DB�� ���� ������ fetch ����
 * �̰� ������ ������ getStaticProps�� ���� server-side������ �۵��ϱ� ����
 * broweser�� ���� JS bundle���� ���� �ʴ´�.
 * �̴� �������� ���� �� ���� ���� �����ͺ��̽��� ������ �ۼ��ؼ� ������ �� �ִٴ� ��

##### �ڵ� ����
 * �ܺ� API
``` next
export async function getSortedPostsData() {
  �� ���� �ý��� ��ſ� �ܺ� API
  �� fetch post data from an external API endpoint
  const res = await fetch('..')
  return res.json()
}
```
 * DB �����̿�
``` next
import someDatabaseSDK from 'someDatabaseSDK'

const databaseClient = someDatabaseSDK.createClient(...)

export async function getSortedPostsData() {
  �� ���� �ý��� ��ſ� DB
  // fetch post data from a database
  return databaseClient.query('SELECT posts...')
}
```

#### Server-side Rendering
 * ������ request���� generate�Ǵ� ���
 * getServerSideProps ���( <-> getStaticProps)

##### getServerSideProps
 * getServerSideProps�� request time���� �����
 * �Ķ���� context�� request�� �����ڸ� �����ϰ� ����
 * request time�� �����Ͱ� fetch�Ǿ�� �ϴ� ��쿡�� ����ؾ� ��
``` next
export async function getServerSideProps(context) {
  return {
    props: {
      // props for your component
    }
  }
}
```

#### Client-side-Rendering
 * �����͸� pre-render�� �ʿ䰡 ���� ��� ���

##### ����
 1. �ܺ� �����͸� �ʿ�� ���� �ʴ� �������� �κе��� ���� �������� generate��
 2. �������� �ε�Ǹ� Ŭ���̾�Ʈ�� �ڹٽ�ũ��Ʈ�� ����� �ܺε����͸� fetch, �����͸� ������
 
##### ���ó
 * ���������� ���� private�� ������ ��� ���������� ���
 * ����� �����Ͱ� ������Ʈ �Ǿ� request�� ������ ���� �ֽ� �����͸� �ʿ�� �� ��� ���
 
##### SWR
 * Client-side-Rendering �� �� ���
 * caching, revalidation, focus tracking, refetching on interval �� ����
 * �ڼ��� ���� [��ũ����](https://swr.vercel.app/)
``` next
import useSWR from 'swr'

function Profile() {
  const { data, error } = useSWR('/api/user', fetch)

  if (error) return <div>failed to load</div>
  if (!data) return <div>loading...</div>
  return <div>hello {data.name}!</div>
}
```

## Dynamic Routes
---

### �⺻����
 * �� ���Ͽ� ���� ������θ� ����

### ��� ���̺귯��

#### Render Markdown
 * ��ġ
``` next
npm install remark remark-html
```

#### Formatting the Date
 * ��ġ
``` next
npm install date-fns
```
 * /components/date.js
``` next
import { parseISO, format } from "date-fns";

export default function Date({ dateString }) {
  const date = parseISO(dateString);
  
  �� format�� ���� ����
  return <time dateTime={dateString}>{format(date, "LLLL d, yyyy")}</time>;
}
```
 * [����](https://date-fns.org/v2.16.1/docs/format)

### �ڵ� ����

#### posts.js

``` next
import fs from 'fs'
import path from 'path'
import matter from 'gray-matter'
import remark from 'remark'
import html from 'remark-html'

�� �� ������ �̸��� id������ �̾� �迭�� ��ȯ
export function getAllPostIds() {
  const fileNames = fs.readdirSync(postsDirectory)
  
  �� map()�Լ�: �迭�� Ư�� ���� �̾Ƽ� ����Ʈ�� ��ȯ
  return fileNames.map(fileName => {
    return {
      params: {
        id: fileName.replace(/\.md$/, '')
      }
    }
  })
}

�� id, html�� ��ȯ�� ��ũ�ٿ�, matterResult.data(title, date ����) ����
export async function getPostData(id) {
  const fullPath = path.join(postsDirectory, `${id}.md`)
  const fileContents = fs.readFileSync(fullPath, 'utf8')

  �� gray-matter�� ����ؼ� metadata section �κ��� �Ľ�
  const matterResult = matter(fileContents)

  �� remark�� ����ؼ� ��ũ�ٿ� ����� ����Ʈ�� html�� ��ȯ
  const processedContent = await remark()
    .use(html)
    .process(matterResult.content)
  const contentHtml = processedContent.toString()

  // Combine the data with the id and contentHtml
  return {
    id,
    contentHtml,
    ...matterResult.data
  }
}
```

#### [id].js
 * Next.js���� dynamic routes�� ����ϱ� ���� ���ϸ��� []�� ���Ѵ�.
 * �� ����(���⼭�� md����)�� render�ϴ� ������
``` next
import Layout from '../../components/layout'
import { getAllPostIds, getPostData } from '../../lib/posts'
import Head from 'next/head'
import Date from '../../components/date'
import utilStyles from '../../styles/utils.module.css'

export default function Post({ postData }) {
  return (
    <Layout>
      <Head>
        <title>{postData.title}</title>
      </Head>

      <article>
        <h1 className={utilStyles.headingXl}>{postData.title}</h1>
        <div className={utilStyles.lightText}>
          <Date dateString={postData.date} />
        </div>
        <div dangerouslySetInnerHTML={{ __html: postData.contentHtml }} />
      </article>
    </Layout>
  );
}

export async function getStaticPaths() {
  const paths = getAllPostIds();
  return {
    paths,
    fallback: false,
  }
}

��  build time�� ���� ���� �����
export async function getStaticProps({ params }) {

  �� import�� posts.js�� getPostData()�� ȣ��
  �� id, html�� ��ȯ�� ��ũ�ٿ�, matterResult.data(title, date ����)�� ����
  const postData = await getPostData(params.id);
  return {
    props: {
      postData,
    },
  };
}
```

#### index.js
``` next
<section className={`${utilStyles.headingMd} ${utilStyles.padding1px}`}>
  <h2 className={utilStyles.headingLg}>Blog</h2>
  <ul className={utilStyles.list}>
    {allPostsData.map(({ id, date, title }) => (
      <li className={utilStyles.listItem} key={id}>
        
        �� posts/[id].js�� ȣ��
        �� ���ϸ��� id ���� �Ǹ� dynamic routes�� �����Ǿ� �־� �ش� ������ �������� ȣ��Ǵ� ���
        <Link href={`/posts/${id}`}>
          {title}
        </Link>
        <br />
        <small className={utilStyles.lightText}>
          <Date dateString={date} />
        </small>
      </li>
    ))}
  </ul>
</section>
```

## getStaticProps 
---

### �⺻����
 * async �Լ��� getStaticProps �Լ��� export�ϸ� Next.js�� getStaticProps�� ���� return�� props�� �̿��� build �ÿ� pre-rendering ��
``` next
export async function getStaticProps(context) {
  return {
    props: {}, // props�� page component�� ���޵� ���Դϴ�.
  }
}
```

### ���ó
 * ����� ��û�� �ռ��� build �ÿ� �������� pre-render�� �̿��� �� �ִ� �����Ͱ� �ִٸ�
 * headless CMS�κ��� ���� �����Ͱ� �ִٸ�
 * cached�� �� �ִ� �����Ͱ� �ִٸ�(����� ���� ����)
 * SEO�� ���� pre-rendering �Ǿ�߸� �ϴ� ���������

### context
 * getStaticProps�� �Ķ����
 * �Ʒ��� ���� key�� ������ object
 
 * ##### params
   * getStaticPaths�Լ��� �Բ� ���Ǿ���
   * dynamic route���� ����ϴ� ������ route parameter�� ����
   * ex) [id].js��� page��� params���� { id: ... }�� ���� ���¸� ����

 * ##### preview
   * preview mode�� �ִٸ� true�̰� �׷��� ������ undefined
   * headless CMS���� data�� fetch�� �� ����
   * Next.js�� build time�� �ƴ� runtime ��û �ÿ� ������ �Խõ� ������ ��� ���� CMS���� draft�� �������� render�ϱ� ���� �� ����

 * ##### previewData 
   * preview mode �ÿ� preview Data set�� ������ ����

 * ##### locale 
   * ���� active locale�� ����

 * ##### locales 
   * ��� supported locales�� ����

 * ##### defaultLocale
   * ������ default locale�� ����
 
### return
 * getStaticProps�� ������ ���� object�� return

 * ##### props
   * required(object)
   * page component�� ���� props object�Դϴ�. serializable object�� �����߸���

 * ##### revalidate
   * optional(number)
   * page re-generate�� �Ͼ �� �ִ� �ð�(�� ����)
   * ������� 1�ʷ� �����س����� ��û�� ���� �� 1�ʸ��� page�� re-generation��
   * ���ο� post�� �����Ǵ��� �� build, �� deploy �ϴ� �� ���� ���� �� ����

 * ##### notFound
   * optional(boolean)
   * 404 page�� return �ϵ��� ��
   * **getStaticPaths**���� fallback: false �� ��쿡�� �ʿ����� ����
     * pre-render�Ǵ� path�鸸 return �Ǳ� ����
``` next
export async function getStaticProps(context) {
  const res = await fetch(`https://.../data`)
  const data = await res.json()

  if (!data) {
    return {
      notFound: true,
    }
  }

  return {
    props: {}, 
  }
}
``` 
 * ##### redirect
   * optinal({ desination: string, permanent: boolean})
   * ���γ� �ܺ� resource�� redirect �ϰ���
``` next
export async function getStaticProps(context) {
  const res = await fetch(`https://...`)
  const data = await res.json()

  if (!data) {
    return {
      redirect: {
        destination: '/',
        permanent: false,
      },
    }
  }

  return {
    props: {},
  }
}
```

### Note
 * build �ÿ� redirecting�� ���� ������ ����
 * build �ÿ� redirect�� ����ϱ� ���� next.config.js�� ������ ���� �߰� �ؾ� ��
``` next
module.exports = {
   async redirects() {
     return [
       {
         source: '/about',
         destination: '/',
         permanent: true,
       },
     ]
   },
 }
```
 * getStaticProps���� top-level scope module�� ��� �� �� ����
 * getStaticProps���� import�� module�� Ŭ���̾�Ʈ ���� ����� �������� ����
   * getStaticProps���� ���� ���� �� �ڵ带 �ۼ��� �� ����
   * ���⿡�� ���� �ý����̳� �����ͺ��̽����� �д� ���� ����
 * top-level scope module
``` next
import { something } from "<module>"; <-- Global / Top-level scope
```
 * getStaticProps���� Application���� API route�� ȣ���ϱ� ���� fetch()�� ����ؼ��� �ȵ�
 * ��� API route ������ ���Ǵ� ����(control)�� ���� �����;� ��
 * �� ���� ����� ���� �ڵ带 �ణ �����丵�ؾ� �� ���� ����
 * �ܺ� API���� ���� ���� ���� ������

## getStaticPaths 
---

### �⺻����
 * dynamic route�� �̿��Ѵٸ�, build �ÿ� HTML�� �����ϱ� ���� path list�� �����ؾ��� �ʿ䰡 ����
 * �̷� ��쿡 getStaticPaths�� ���
 * Next.js�� getStaticPaths�� ���ǵ� ��� path�� ���� �������� pre-rendering�� ��
 * server-side���� build �ÿ��� ����
 * page������ ���
 * ���� �ÿ��� ��� ��û�� ���� ����
```next
export async function getStaticPaths() {
  return {
    paths: [
      { params: { ... } } 
    ],
    fallback: true or false 
  };
}
```

### ���ó
 * dynamic route�� ����� ���� pre-rendering page�� �ִٸ� ����ؾ߸���
   * getServerSideProps�ʹ� �Բ� ����� �� ����

### return
 * ##### paths
   * required
   * pre-render�Ǵ� path�� ����
   * ex) pages/posts/[id].js�� dynamic route�� ������ٰ� ����
``` next
export async function getStaticPaths() {
  return {
    paths: [
      { params: { id: '1' } },
      { params: { id: '2' } }
    ],
    fallback: ...
  }
}
```
   * Next.js�� posts/1 posts/2�� pages/posts/[id].js�� ����Ͽ� build �ÿ� �������� ����
   * posts/1 posts/2�� pages/posts/[id].js�� ����Ͽ� build �ÿ� �������� ����
   * params�� dynamic route���� page pathname���� ���� parameter�� match�Ǿ�߸� ��
 * ##### fallback
   * required
   * **false**
     * getStaticPaths�� path�� ���ǵ��� ���� ���� 404 page�� ����
	 * pre-render�ϴ� path list�� ���� �ʴٸ�(build�ÿ� ��� ���� �����Ǳ� �����Դϴ�) ����� �� ����
	 * ���ο� page�� �߰��Ǿ��� ���� build�� �����ؾ� 404 page�� ���� ����
   * **true**
     * �ſ� ���� ���� ���� ��������(e-commerce site�� ����? ����� �����Ϳ� �����ϴ�)�� �ִ� app ���� ����
	 * build �ÿ� ���� ���� �ʾҴ� path���� 404 page�� ������ ����
	 * ��� Next.js�� �̷��� path�鿡 ���ؼ� ù ��û�� ������ "��ü" ����(fallback ����)�� ����
	   * background������ Next.js�� ��û�� path�� ���� �������� HTML�� JSON�� ������ ���̰� getStaticProps�� �Ѱ���
	   * ����� ���������� fallback page���� ������ page�� swap�� ��
	   * ���ÿ� Next.js�� �� path�� pre-render page ����Ʈ�� �߰�
	   * �׸��� �ļ� ��û�� ���� ������ page(build �� pre-rendering ������)�� �����ϰ� ����
	 * next export ���ÿ��� �������� ����
	 * Fallback page
	   * next/router�� ����� fallback ���� üũ
	   * router.isFallback === true
``` next
�� pages/posts/[id].js

import { useRouter } from 'next/router'

function Post({ post }) {
  const router = useRouter()

  �� ���� ���� page�� �������� �ʾҴٸ�, �Ʒ��� ����
  �� Loading...�̶�� ���ڸ� �����ݴϴ�.
  �� (getStaticProps() ������ ������ ������)
  if (router.isFallback) {
    return <div>Loading...</div>
  }

  �� Render post...
}

�� build time �� ȣ��
export async function getStaticPaths() {
  return {
  
    �� ���� ���� : `/posts/1` and `/posts/2`
    paths: [{ params: { id: '1' } }, { params: { id: '2' } }],
    �� `/posts/3` �� ���� 
    fallback: true,
  }
}

export async function getStaticProps({ params }) {
  const res = await fetch(`https://.../posts/${params.id}`)
  const post = await res.json()

  return {
    props: { post },
    �� ��û�� ���´ٸ�
    �� �� 1�ʴ� post�� �� ���� �Ұ��Դϴ�.
    revalidate: 1,
  }
}

export default Post
```

## TypeScript
---

### ��ġ
``` next
npm install --save-dev typescript @types/react @types/node
```

-----------------------------------------------------------

npm i axios

useEffect, useState

npm install semantic-ui-react semantic-ui-css

